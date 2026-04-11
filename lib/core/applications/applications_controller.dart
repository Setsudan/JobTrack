import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import 'package:job_application_tracker/core/applications/application_archive_label.dart';
import 'package:job_application_tracker/core/models/job_application.dart';
import 'package:job_application_tracker/core/models/job_application_status.dart';
import 'package:job_application_tracker/data/isar/isar_schemas.dart';
import 'package:job_application_tracker/data/isar/job_application_isar_mapper.dart';

class ApplicationsController extends ChangeNotifier {
  ApplicationsController(
    this._isar, {
    Future<void> Function(List<JobApplication> apps)? onApplicationsPersisted,
  }) : _onApplicationsPersisted = onApplicationsPersisted;

  final Isar _isar;
  final Future<void> Function(List<JobApplication> apps)?
  _onApplicationsPersisted;

  List<JobApplication> _applications = <JobApplication>[];
  List<JobApplication> _activeView = <JobApplication>[];
  List<JobApplication> _archivedView = <JobApplication>[];

  List<JobApplication> get applications => List.unmodifiable(_applications);

  /// Cheap value for [context.select] so tabs rebuild only when stored data changes.
  int get changeSignature {
    var h = _applications.length;
    for (final JobApplication a in _applications) {
      h = Object.hash(
        h,
        a.id,
        a.status,
        a.isArchived,
        a.submittedOn,
        a.jobTitle,
        a.companyName,
        a.postingUrl,
        a.archiveGroupLabel,
      );
    }
    return h;
  }

  /// Rebuild listeners for a single application row/editor only when that row changes.
  int changeSignatureForId(String id) {
    final JobApplication? a = byId(id);
    if (a == null) {
      return 0;
    }
    return Object.hash(
      a.id,
      a.status,
      a.isArchived,
      a.submittedOn,
      a.jobTitle,
      a.companyName,
      a.postingUrl,
      a.archiveGroupKey,
      a.archiveGroupLabel,
    );
  }

  List<JobApplication> activeApplications() {
    return _activeView;
  }

  List<JobApplication> archivedApplications() {
    return _archivedView;
  }

  JobApplication? byId(String id) {
    for (final a in _applications) {
      if (a.id == id) {
        return a;
      }
    }
    return null;
  }

  Future<void> init() async {
    _load();
    notifyListeners();
  }

  void _load() {
    final entities = _isar.jobApplicationEntitys.where().findAllSync();
    _applications = entities.map(jobApplicationFromEntity).toList();
    _sortApplications();
    _rebuildDerivedLists();
  }

  void _sortApplications() {
    _applications.sort((JobApplication a, JobApplication b) {
      final int c = b.submittedOn.compareTo(a.submittedOn);
      if (c != 0) {
        return c;
      }
      return b.id.compareTo(a.id);
    });
  }

  void _rebuildDerivedLists() {
    if (_applications.isEmpty) {
      _activeView = <JobApplication>[];
      _archivedView = <JobApplication>[];
      return;
    }
    final active = <JobApplication>[];
    final archived = <JobApplication>[];
    for (final JobApplication a in _applications) {
      if (a.isArchived) {
        archived.add(a);
      } else {
        active.add(a);
      }
    }
    _activeView = List<JobApplication>.unmodifiable(active);
    _archivedView = List<JobApplication>.unmodifiable(archived);
  }

  void _scheduleApplicationsHook() {
    final Future<void> Function(List<JobApplication>)? hook =
        _onApplicationsPersisted;
    if (hook != null) {
      final List<JobApplication> snap = List<JobApplication>.from(
        _applications,
      );
      scheduleMicrotask(() {
        unawaited(hook(snap));
      });
    }
  }

  Future<void> _afterMutation() async {
    _rebuildDerivedLists();
    notifyListeners();
    _scheduleApplicationsHook();
  }

  Future<void> add(JobApplication application) async {
    await _isar.writeTxn(() async {
      await _isar.jobApplicationEntitys.putByApplicationId(
        jobApplicationToEntity(application),
      );
    });
    _applications = <JobApplication>[
      application,
      ..._applications.where((JobApplication a) => a.id != application.id),
    ];
    _sortApplications();
    await _afterMutation();
  }

  Future<void> importApplications(List<JobApplication> imported) async {
    if (imported.isEmpty) {
      return;
    }
    await _isar.writeTxn(() async {
      for (final JobApplication app in imported) {
        await _isar.jobApplicationEntitys.putByApplicationId(
          jobApplicationToEntity(app),
        );
      }
    });
    final Set<String> importedIds = imported
        .map((JobApplication e) => e.id)
        .toSet();
    _applications = <JobApplication>[
      ...imported,
      ..._applications.where((JobApplication a) => !importedIds.contains(a.id)),
    ];
    _sortApplications();
    await _afterMutation();
  }

  Future<void> update(JobApplication application) async {
    final int i = _applications.indexWhere(
      (JobApplication a) => a.id == application.id,
    );
    if (i < 0) {
      return;
    }
    await _isar.writeTxn(() async {
      await _isar.jobApplicationEntitys.putByApplicationId(
        jobApplicationToEntity(application),
      );
    });
    _applications[i] = application;
    _sortApplications();
    await _afterMutation();
  }

  Future<void> remove(String id) async {
    await _isar.writeTxn(() async {
      await _isar.jobApplicationEntitys.deleteByApplicationId(id);
    });
    _applications = _applications
        .where((JobApplication a) => a.id != id)
        .toList();
    await _afterMutation();
  }

  /// Archives every active application except [exceptId]. [groupLabel] is localized for display.
  Future<void> archiveAllActiveExcept({
    required String exceptId,
    required DateTime at,
    required String groupLabel,
  }) async {
    final toArchive = _applications.where((JobApplication a) {
      return !a.isArchived && a.id != exceptId;
    }).toList();
    if (toArchive.isEmpty) {
      return;
    }
    final modeTitle = modeDisplayJobTitle(
      toArchive.map((JobApplication a) => a.jobTitle),
    );
    final key = archiveGroupKeyFor(at: at, displayJobTitle: modeTitle);

    await _isar.writeTxn(() async {
      for (var i = 0; i < _applications.length; i++) {
        final JobApplication a = _applications[i];
        if (!a.isArchived && a.id != exceptId) {
          final JobApplication updated = a.copyWith(
            isArchived: true,
            archiveGroupKey: key,
            archiveGroupLabel: groupLabel,
          );
          await _isar.jobApplicationEntitys.putByApplicationId(
            jobApplicationToEntity(updated),
          );
        }
      }
    });

    for (var i = 0; i < _applications.length; i++) {
      final JobApplication a = _applications[i];
      if (!a.isArchived && a.id != exceptId) {
        _applications[i] = a.copyWith(
          isArchived: true,
          archiveGroupKey: key,
          archiveGroupLabel: groupLabel,
        );
      }
    }
    _sortApplications();
    await _afterMutation();
  }

  List<JobApplication> decisionPendingActiveExcept(String exceptId) {
    return _applications.where((JobApplication a) {
      return !a.isArchived &&
          a.id != exceptId &&
          a.status == JobApplicationStatus.decisionPending;
    }).toList();
  }
}
