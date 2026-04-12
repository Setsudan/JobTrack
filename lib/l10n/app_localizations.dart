import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// Application name shown in task switcher and about.
  ///
  /// In en, this message translates to:
  /// **'JobTrack'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navApplications.
  ///
  /// In en, this message translates to:
  /// **'Applications'**
  String get navApplications;

  /// No description provided for @navNewApplication.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get navNewApplication;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @homeWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Your search, organized'**
  String get homeWelcomeTitle;

  /// No description provided for @homeWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track links, dates, and outcomes in one calm place.'**
  String get homeWelcomeSubtitle;

  /// Heading above the home stats grid.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get homeStatsSectionTitle;

  /// Home stat: count of non-archived applications.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get homeStatActiveTitle;

  /// Home stat: applied or no reply yet, still waiting on employer.
  ///
  /// In en, this message translates to:
  /// **'Awaiting their reply'**
  String get homeStatWaitingTitle;

  /// Home stat: interview scheduled.
  ///
  /// In en, this message translates to:
  /// **'Interviews'**
  String get homeStatInterviewTitle;

  /// Home stat: archived applications count.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get homeStatArchivedTitle;

  /// No description provided for @homeRecentApplications.
  ///
  /// In en, this message translates to:
  /// **'Recently updated'**
  String get homeRecentApplications;

  /// No description provided for @homeViewAllApplications.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get homeViewAllApplications;

  /// No description provided for @applicationsListTitle.
  ///
  /// In en, this message translates to:
  /// **'Applications'**
  String get applicationsListTitle;

  /// No description provided for @applicationsActiveTab.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get applicationsActiveTab;

  /// No description provided for @applicationsArchivedTab.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get applicationsArchivedTab;

  /// No description provided for @applicationsEmptyActive.
  ///
  /// In en, this message translates to:
  /// **'No active applications yet. Add one from New.'**
  String get applicationsEmptyActive;

  /// No description provided for @applicationsEmptyArchived.
  ///
  /// In en, this message translates to:
  /// **'No archived applications.'**
  String get applicationsEmptyArchived;

  /// No description provided for @applicationCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'New application'**
  String get applicationCreateTitle;

  /// No description provided for @labelJobPostingUrl.
  ///
  /// In en, this message translates to:
  /// **'Job link'**
  String get labelJobPostingUrl;

  /// No description provided for @hintJobPostingUrl.
  ///
  /// In en, this message translates to:
  /// **'Paste the posting URL'**
  String get hintJobPostingUrl;

  /// No description provided for @buttonFetchJobDetails.
  ///
  /// In en, this message translates to:
  /// **'Load details from link'**
  String get buttonFetchJobDetails;

  /// No description provided for @jobMetadataFetchFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not read details from that link. You can still fill the fields yourself.'**
  String get jobMetadataFetchFailed;

  /// No description provided for @jobMetadataNothingFound.
  ///
  /// In en, this message translates to:
  /// **'No title was detected. Enter the role and company manually.'**
  String get jobMetadataNothingFound;

  /// No description provided for @labelJobTitle.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get labelJobTitle;

  /// No description provided for @labelCompanyName.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get labelCompanyName;

  /// No description provided for @labelDateSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Date sent'**
  String get labelDateSubmitted;

  /// Date row when status is saved for later (draft).
  ///
  /// In en, this message translates to:
  /// **'Reminder to apply'**
  String get labelReminderToApplyDate;

  /// Scheduled local notification title for draft applications.
  ///
  /// In en, this message translates to:
  /// **'Apply reminder'**
  String get draftApplyReminderNotificationTitle;

  /// Scheduled notification body; use a hyphen for unknown parts.
  ///
  /// In en, this message translates to:
  /// **'Remember to apply for {roleName} at {companyName}.'**
  String draftApplyReminderNotificationBody(
    String roleName,
    String companyName,
  );

  /// Android system notification channel name for draft apply reminders.
  ///
  /// In en, this message translates to:
  /// **'Apply reminders'**
  String get notificationChannelDraftRemindersName;

  /// Android notification channel description.
  ///
  /// In en, this message translates to:
  /// **'Reminders for postings saved for later'**
  String get notificationChannelDraftRemindersDescription;

  /// No description provided for @labelApplicationStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get labelApplicationStatus;

  /// No description provided for @buttonSaveApplication.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get buttonSaveApplication;

  /// No description provided for @applicationSaved.
  ///
  /// In en, this message translates to:
  /// **'Application saved'**
  String get applicationSaved;

  /// No description provided for @applicationUrlRequired.
  ///
  /// In en, this message translates to:
  /// **'Add a valid job link before saving.'**
  String get applicationUrlRequired;

  /// No description provided for @applicationDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Application'**
  String get applicationDetailTitle;

  /// No description provided for @applicationOpenPosting.
  ///
  /// In en, this message translates to:
  /// **'Open posting'**
  String get applicationOpenPosting;

  /// No description provided for @applicationDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get applicationDelete;

  /// No description provided for @applicationDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this application?'**
  String get applicationDeleteConfirmTitle;

  /// No description provided for @applicationDeleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This cannot be undone.'**
  String get applicationDeleteConfirmBody;

  /// No description provided for @applicationConfirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get applicationConfirmDelete;

  /// Pipeline: not sent yet.
  ///
  /// In en, this message translates to:
  /// **'Saved for later'**
  String get jobStatusDraft;

  /// No description provided for @jobStatusSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get jobStatusSubmitted;

  /// No description provided for @jobStatusNoResponseYet.
  ///
  /// In en, this message translates to:
  /// **'No reply yet'**
  String get jobStatusNoResponseYet;

  /// No description provided for @jobStatusInterviewScheduled.
  ///
  /// In en, this message translates to:
  /// **'Interview scheduled'**
  String get jobStatusInterviewScheduled;

  /// No description provided for @jobStatusDecisionPending.
  ///
  /// In en, this message translates to:
  /// **'Waiting on their decision'**
  String get jobStatusDecisionPending;

  /// No description provided for @jobStatusClosedNotSelected.
  ///
  /// In en, this message translates to:
  /// **'Moving on'**
  String get jobStatusClosedNotSelected;

  /// No description provided for @jobStatusOfferAccepted.
  ///
  /// In en, this message translates to:
  /// **'Offer accepted'**
  String get jobStatusOfferAccepted;

  /// No description provided for @archiveSemesterFirstHalf.
  ///
  /// In en, this message translates to:
  /// **'1st semester'**
  String get archiveSemesterFirstHalf;

  /// No description provided for @archiveSemesterSecondHalf.
  ///
  /// In en, this message translates to:
  /// **'2nd semester'**
  String get archiveSemesterSecondHalf;

  /// No description provided for @archiveUntitledRole.
  ///
  /// In en, this message translates to:
  /// **'Applications'**
  String get archiveUntitledRole;

  /// No description provided for @archiveGroupDisplay.
  ///
  /// In en, this message translates to:
  /// **'{jobTitle} - {semesterLabel} {year}'**
  String archiveGroupDisplay(
    String jobTitle,
    String semesterLabel,
    String year,
  );

  /// No description provided for @hireAskJobHuntDoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Close your search?'**
  String get hireAskJobHuntDoneTitle;

  /// No description provided for @hireAskJobHuntDoneBody.
  ///
  /// In en, this message translates to:
  /// **'Are you done looking for a role for now?'**
  String get hireAskJobHuntDoneBody;

  /// No description provided for @hireJobHuntDoneNo.
  ///
  /// In en, this message translates to:
  /// **'Still exploring'**
  String get hireJobHuntDoneNo;

  /// No description provided for @hireJobHuntDoneYes.
  ///
  /// In en, this message translates to:
  /// **'Yes, I am done'**
  String get hireJobHuntDoneYes;

  /// No description provided for @hireCongratulationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Congratulations'**
  String get hireCongratulationsTitle;

  /// No description provided for @hireCongratulationsBody.
  ///
  /// In en, this message translates to:
  /// **'You earned this. Take a moment to enjoy the win.'**
  String get hireCongratulationsBody;

  /// No description provided for @hireAskDisposalTitle.
  ///
  /// In en, this message translates to:
  /// **'Other applications'**
  String get hireAskDisposalTitle;

  /// No description provided for @hireAskDisposalBody.
  ///
  /// In en, this message translates to:
  /// **'What should we do with your other active applications?'**
  String get hireAskDisposalBody;

  /// No description provided for @hireKeepApplications.
  ///
  /// In en, this message translates to:
  /// **'Keep them visible'**
  String get hireKeepApplications;

  /// No description provided for @hireArchiveApplications.
  ///
  /// In en, this message translates to:
  /// **'Archive them'**
  String get hireArchiveApplications;

  /// No description provided for @archiveReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Let them know'**
  String get archiveReminderTitle;

  /// No description provided for @archiveReminderBody.
  ///
  /// In en, this message translates to:
  /// **'These applications are still waiting for a final answer. Consider sending a short note that you accepted another offer so everyone can move on cleanly.'**
  String get archiveReminderBody;

  /// No description provided for @archiveReminderEmptyList.
  ///
  /// In en, this message translates to:
  /// **'None of your other applications are in the waiting-on-decision stage. You can still archive everything for a fresh start.'**
  String get archiveReminderEmptyList;

  /// No description provided for @archiveConfirmArchive.
  ///
  /// In en, this message translates to:
  /// **'Archive all others'**
  String get archiveConfirmArchive;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// Tooltip or label for closing a sheet or dialog.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @sectionAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get sectionAppearance;

  /// No description provided for @sectionLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get sectionLanguage;

  /// No description provided for @labelBackground.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get labelBackground;

  /// No description provided for @labelDisplayLanguage.
  ///
  /// In en, this message translates to:
  /// **'Display language'**
  String get labelDisplayLanguage;

  /// No description provided for @appearanceSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get appearanceSystem;

  /// No description provided for @appearanceWhite.
  ///
  /// In en, this message translates to:
  /// **'White'**
  String get appearanceWhite;

  /// No description provided for @appearanceBlack.
  ///
  /// In en, this message translates to:
  /// **'Black'**
  String get appearanceBlack;

  /// No description provided for @appearanceAmoledBlack.
  ///
  /// In en, this message translates to:
  /// **'AMOLED black'**
  String get appearanceAmoledBlack;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystem;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get languageFrench;

  /// No description provided for @foundationBlurb.
  ///
  /// In en, this message translates to:
  /// **'Theme and language apply everywhere in the app.'**
  String get foundationBlurb;

  /// Active applications count on home.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No applications yet} one{1 application} other{{count} applications}}'**
  String applicationsCount(num count);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @profileSectionIdentity.
  ///
  /// In en, this message translates to:
  /// **'Identity'**
  String get profileSectionIdentity;

  /// No description provided for @profileSectionContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get profileSectionContact;

  /// No description provided for @profileSectionSocial.
  ///
  /// In en, this message translates to:
  /// **'Social links'**
  String get profileSectionSocial;

  /// No description provided for @profileSectionResumes.
  ///
  /// In en, this message translates to:
  /// **'Resumes'**
  String get profileSectionResumes;

  /// No description provided for @labelProfileDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get labelProfileDisplayName;

  /// No description provided for @labelProfileHeadline.
  ///
  /// In en, this message translates to:
  /// **'Headline'**
  String get labelProfileHeadline;

  /// No description provided for @labelProfileEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get labelProfileEmail;

  /// No description provided for @labelProfilePhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get labelProfilePhone;

  /// No description provided for @labelProfileBio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get labelProfileBio;

  /// No description provided for @labelProfileGithub.
  ///
  /// In en, this message translates to:
  /// **'GitHub URL'**
  String get labelProfileGithub;

  /// No description provided for @labelProfileGitlab.
  ///
  /// In en, this message translates to:
  /// **'GitLab URL'**
  String get labelProfileGitlab;

  /// No description provided for @labelProfileLinkedin.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn URL'**
  String get labelProfileLinkedin;

  /// No description provided for @labelProfileDribbble.
  ///
  /// In en, this message translates to:
  /// **'Dribbble URL'**
  String get labelProfileDribbble;

  /// No description provided for @labelProfileBehance.
  ///
  /// In en, this message translates to:
  /// **'Behance URL'**
  String get labelProfileBehance;

  /// No description provided for @profileSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get profileSave;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile saved'**
  String get profileSaved;

  /// No description provided for @profileShare.
  ///
  /// In en, this message translates to:
  /// **'Share profile card'**
  String get profileShare;

  /// No description provided for @profileShareSubject.
  ///
  /// In en, this message translates to:
  /// **'Profile card'**
  String get profileShareSubject;

  /// No description provided for @profileShareEmpty.
  ///
  /// In en, this message translates to:
  /// **'Add your name, contact, or a social link before sharing.'**
  String get profileShareEmpty;

  /// No description provided for @profileInvalidUrl.
  ///
  /// In en, this message translates to:
  /// **'That URL does not look valid. Check the field and try again.'**
  String get profileInvalidUrl;

  /// No description provided for @profileAddResume.
  ///
  /// In en, this message translates to:
  /// **'Add resume'**
  String get profileAddResume;

  /// No description provided for @profileOpenResume.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get profileOpenResume;

  /// No description provided for @profileRemoveResume.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get profileRemoveResume;

  /// No description provided for @profileResumeUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Saving resumes is not available on this platform.'**
  String get profileResumeUnsupported;

  /// No description provided for @profileResumeReadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not read that file.'**
  String get profileResumeReadFailed;

  /// No description provided for @profileResumeWriteFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not save that file.'**
  String get profileResumeWriteFailed;

  /// No description provided for @profileOpenResumeFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open that file.'**
  String get profileOpenResumeFailed;

  /// No description provided for @socialLinkGithub.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get socialLinkGithub;

  /// No description provided for @socialLinkGitlab.
  ///
  /// In en, this message translates to:
  /// **'GitLab'**
  String get socialLinkGitlab;

  /// No description provided for @socialLinkLinkedin.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn'**
  String get socialLinkLinkedin;

  /// No description provided for @socialLinkDribbble.
  ///
  /// In en, this message translates to:
  /// **'Dribbble'**
  String get socialLinkDribbble;

  /// No description provided for @socialLinkBehance.
  ///
  /// In en, this message translates to:
  /// **'Behance'**
  String get socialLinkBehance;

  /// No description provided for @profileAddSocialLink.
  ///
  /// In en, this message translates to:
  /// **'Add another link'**
  String get profileAddSocialLink;

  /// No description provided for @profileRemoveSocialLink.
  ///
  /// In en, this message translates to:
  /// **'Remove link'**
  String get profileRemoveSocialLink;

  /// No description provided for @profileSocialLinksEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Add portfolio or social links if you like.'**
  String get profileSocialLinksEmptyHint;

  /// No description provided for @profileUrlHint.
  ///
  /// In en, this message translates to:
  /// **'https://'**
  String get profileUrlHint;

  /// No description provided for @sectionSwipeShortcuts.
  ///
  /// In en, this message translates to:
  /// **'List swipe shortcuts'**
  String get sectionSwipeShortcuts;

  /// No description provided for @settingsSwipeStartPaneLabel.
  ///
  /// In en, this message translates to:
  /// **'Start-side card swipe'**
  String get settingsSwipeStartPaneLabel;

  /// No description provided for @settingsSwipeStartPaneHint.
  ///
  /// In en, this message translates to:
  /// **'Opens when you swipe outward on the leading edge of the card in your reading direction.'**
  String get settingsSwipeStartPaneHint;

  /// No description provided for @settingsSwipeEndPaneLabel.
  ///
  /// In en, this message translates to:
  /// **'End-side card swipe'**
  String get settingsSwipeEndPaneLabel;

  /// No description provided for @settingsSwipeEndPaneHint.
  ///
  /// In en, this message translates to:
  /// **'Opens when you swipe outward on the trailing edge of the card in your reading direction.'**
  String get settingsSwipeEndPaneHint;

  /// No description provided for @swipeShortcutAdvanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Advance one stage'**
  String get swipeShortcutAdvanceLabel;

  /// No description provided for @applicationSwipeStatusUpdated.
  ///
  /// In en, this message translates to:
  /// **'Updated to {statusLabel}.'**
  String applicationSwipeStatusUpdated(String statusLabel);

  /// No description provided for @sectionFollowUpReminders.
  ///
  /// In en, this message translates to:
  /// **'Follow-up reminders'**
  String get sectionFollowUpReminders;

  /// No description provided for @settingsWaitingFollowUpDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Waiting reply reminder (days)'**
  String get settingsWaitingFollowUpDaysLabel;

  /// No description provided for @settingsWaitingFollowUpDaysHint.
  ///
  /// In en, this message translates to:
  /// **'For active applications in Applied or No reply yet, schedule a local reminder when the date is at least this many days old (3 to 30).'**
  String get settingsWaitingFollowUpDaysHint;

  /// No description provided for @applicationsListMenuTooltip.
  ///
  /// In en, this message translates to:
  /// **'More options'**
  String get applicationsListMenuTooltip;

  /// No description provided for @applicationsMenuImportCsv.
  ///
  /// In en, this message translates to:
  /// **'Import CSV'**
  String get applicationsMenuImportCsv;

  /// No description provided for @csvImportParseFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not read that CSV file.'**
  String get csvImportParseFailed;

  /// No description provided for @csvImportTitle.
  ///
  /// In en, this message translates to:
  /// **'Import from CSV'**
  String get csvImportTitle;

  /// No description provided for @csvImportSummary.
  ///
  /// In en, this message translates to:
  /// **'Imported {importedCount}. Skipped {skippedCount}.'**
  String csvImportSummary(int importedCount, int skippedCount);

  /// No description provided for @csvImportNoRows.
  ///
  /// In en, this message translates to:
  /// **'No rows to import.'**
  String get csvImportNoRows;

  /// No description provided for @csvImportHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Expected columns'**
  String get csvImportHelpTitle;

  /// No description provided for @csvImportHelpBody.
  ///
  /// In en, this message translates to:
  /// **'The first row should name columns. Supported headers include job link, URL, posting URL, title, role, company, date (YYYY-MM-DD), and optional status.'**
  String get csvImportHelpBody;

  /// No description provided for @csvImportMissingHeaders.
  ///
  /// In en, this message translates to:
  /// **'Could not find a job link column.'**
  String get csvImportMissingHeaders;

  /// No description provided for @waitingFollowUpNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Follow up on an application'**
  String get waitingFollowUpNotificationTitle;

  /// No description provided for @waitingFollowUpNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'Check in on {roleName} at {companyName}.'**
  String waitingFollowUpNotificationBody(String roleName, String companyName);

  /// No description provided for @notificationChannelWaitingFollowUpsName.
  ///
  /// In en, this message translates to:
  /// **'Waiting reply reminders'**
  String get notificationChannelWaitingFollowUpsName;

  /// No description provided for @notificationChannelWaitingFollowUpsDescription.
  ///
  /// In en, this message translates to:
  /// **'Nudges for applications still in Applied or No reply yet'**
  String get notificationChannelWaitingFollowUpsDescription;

  /// No description provided for @sectionAppWallpaper.
  ///
  /// In en, this message translates to:
  /// **'App backdrop'**
  String get sectionAppWallpaper;

  /// No description provided for @appWallpaperModeNone.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get appWallpaperModeNone;

  /// No description provided for @appWallpaperModeImage.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get appWallpaperModeImage;

  /// No description provided for @appWallpaperModeGradient.
  ///
  /// In en, this message translates to:
  /// **'Gradient'**
  String get appWallpaperModeGradient;

  /// No description provided for @appWallpaperModeAnimated.
  ///
  /// In en, this message translates to:
  /// **'Animated'**
  String get appWallpaperModeAnimated;

  /// No description provided for @appWallpaperChooseImage.
  ///
  /// In en, this message translates to:
  /// **'Choose photo'**
  String get appWallpaperChooseImage;

  /// No description provided for @appWallpaperClearImage.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get appWallpaperClearImage;

  /// No description provided for @appWallpaperImageImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not use that image. Try another format.'**
  String get appWallpaperImageImportFailed;

  /// App bar title for the wallpaper crop and align step.
  ///
  /// In en, this message translates to:
  /// **'Position photo'**
  String get appWallpaperCropTitle;

  /// Short instructions on the wallpaper crop screen.
  ///
  /// In en, this message translates to:
  /// **'Drag to move the photo. Pinch to zoom. The frame matches your screen shape.'**
  String get appWallpaperCropHint;

  /// Primary button to confirm cropped wallpaper.
  ///
  /// In en, this message translates to:
  /// **'Use as backdrop'**
  String get appWallpaperCropApply;

  /// Shown when the crop tool fails to output an image.
  ///
  /// In en, this message translates to:
  /// **'Could not prepare that crop. Try again.'**
  String get appWallpaperCropFailed;

  /// No description provided for @appWallpaperStaticPresetsLabel.
  ///
  /// In en, this message translates to:
  /// **'Gradient style'**
  String get appWallpaperStaticPresetsLabel;

  /// No description provided for @appWallpaperAnimatedPresetsLabel.
  ///
  /// In en, this message translates to:
  /// **'Animated style'**
  String get appWallpaperAnimatedPresetsLabel;

  /// No description provided for @appWallpaperPresetOcean.
  ///
  /// In en, this message translates to:
  /// **'Ocean'**
  String get appWallpaperPresetOcean;

  /// No description provided for @appWallpaperPresetSunset.
  ///
  /// In en, this message translates to:
  /// **'Sunset'**
  String get appWallpaperPresetSunset;

  /// No description provided for @appWallpaperPresetTwilight.
  ///
  /// In en, this message translates to:
  /// **'Twilight'**
  String get appWallpaperPresetTwilight;

  /// No description provided for @appWallpaperPresetSage.
  ///
  /// In en, this message translates to:
  /// **'Sage'**
  String get appWallpaperPresetSage;

  /// No description provided for @appWallpaperPresetCoral.
  ///
  /// In en, this message translates to:
  /// **'Coral'**
  String get appWallpaperPresetCoral;

  /// No description provided for @appWallpaperPresetGlacier.
  ///
  /// In en, this message translates to:
  /// **'Glacier'**
  String get appWallpaperPresetGlacier;

  /// No description provided for @appWallpaperPresetMidnight.
  ///
  /// In en, this message translates to:
  /// **'Midnight'**
  String get appWallpaperPresetMidnight;

  /// No description provided for @appWallpaperPresetLavender.
  ///
  /// In en, this message translates to:
  /// **'Lavender'**
  String get appWallpaperPresetLavender;

  /// No description provided for @appWallpaperPresetRoseGold.
  ///
  /// In en, this message translates to:
  /// **'Rose gold'**
  String get appWallpaperPresetRoseGold;

  /// No description provided for @appWallpaperPresetSandDune.
  ///
  /// In en, this message translates to:
  /// **'Sand dune'**
  String get appWallpaperPresetSandDune;

  /// No description provided for @appWallpaperPresetCherryMist.
  ///
  /// In en, this message translates to:
  /// **'Cherry mist'**
  String get appWallpaperPresetCherryMist;

  /// No description provided for @appWallpaperAnimatedAurora.
  ///
  /// In en, this message translates to:
  /// **'Aurora'**
  String get appWallpaperAnimatedAurora;

  /// No description provided for @appWallpaperAnimatedEmber.
  ///
  /// In en, this message translates to:
  /// **'Ember'**
  String get appWallpaperAnimatedEmber;

  /// No description provided for @appWallpaperAnimatedNebula.
  ///
  /// In en, this message translates to:
  /// **'Nebula'**
  String get appWallpaperAnimatedNebula;

  /// No description provided for @appWallpaperAnimatedPrism.
  ///
  /// In en, this message translates to:
  /// **'Prism'**
  String get appWallpaperAnimatedPrism;

  /// No description provided for @appWallpaperAnimatedTide.
  ///
  /// In en, this message translates to:
  /// **'Tide'**
  String get appWallpaperAnimatedTide;

  /// No description provided for @appWallpaperAnimatedComet.
  ///
  /// In en, this message translates to:
  /// **'Comet'**
  String get appWallpaperAnimatedComet;

  /// No description provided for @appWallpaperAnimatedForge.
  ///
  /// In en, this message translates to:
  /// **'Forge'**
  String get appWallpaperAnimatedForge;

  /// No description provided for @appWallpaperAnimatedMeadow.
  ///
  /// In en, this message translates to:
  /// **'Meadow'**
  String get appWallpaperAnimatedMeadow;

  /// Title when app bootstrap fails before the main UI loads.
  ///
  /// In en, this message translates to:
  /// **'Could not start JobTrack'**
  String get startupFailureTitle;

  /// No description provided for @startupFailureBody.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while loading your data. Details were written to a log file on this device.'**
  String get startupFailureBody;

  /// No description provided for @startupFailureLogPathLabel.
  ///
  /// In en, this message translates to:
  /// **'Log file path'**
  String get startupFailureLogPathLabel;

  /// No description provided for @startupFailureTechnicalHint.
  ///
  /// In en, this message translates to:
  /// **'Technical summary'**
  String get startupFailureTechnicalHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
