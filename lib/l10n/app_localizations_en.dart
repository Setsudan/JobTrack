// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'JobTrack';

  @override
  String get navHome => 'Home';

  @override
  String get navApplications => 'Applications';

  @override
  String get navNewApplication => 'New';

  @override
  String get navProfile => 'Profile';

  @override
  String get profileTitle => 'Profile';

  @override
  String get homeWelcomeTitle => 'Your search, organized';

  @override
  String get homeWelcomeSubtitle =>
      'Track links, dates, and outcomes in one calm place.';

  @override
  String get homeStatsSectionTitle => 'Overview';

  @override
  String get homeStatActiveTitle => 'Active';

  @override
  String get homeStatWaitingTitle => 'Awaiting their reply';

  @override
  String get homeStatInterviewTitle => 'Interviews';

  @override
  String get homeStatArchivedTitle => 'Archived';

  @override
  String get homeRecentApplications => 'Recently updated';

  @override
  String get homeViewAllApplications => 'View all';

  @override
  String get applicationsListTitle => 'Applications';

  @override
  String get applicationsActiveTab => 'Active';

  @override
  String get applicationsArchivedTab => 'Archived';

  @override
  String get applicationsEmptyActive =>
      'No active applications yet. Add one from New.';

  @override
  String get applicationsEmptyArchived => 'No archived applications.';

  @override
  String get applicationCreateTitle => 'New application';

  @override
  String get labelJobPostingUrl => 'Job link';

  @override
  String get hintJobPostingUrl => 'Paste the posting URL';

  @override
  String get buttonFetchJobDetails => 'Load details from link';

  @override
  String get jobMetadataFetchFailed =>
      'Could not read details from that link. You can still fill the fields yourself.';

  @override
  String get jobMetadataNothingFound =>
      'No title was detected. Enter the role and company manually.';

  @override
  String get labelJobTitle => 'Role';

  @override
  String get labelCompanyName => 'Company';

  @override
  String get labelDateSubmitted => 'Date sent';

  @override
  String get labelReminderToApplyDate => 'Reminder to apply';

  @override
  String get draftApplyReminderNotificationTitle => 'Apply reminder';

  @override
  String draftApplyReminderNotificationBody(
    String roleName,
    String companyName,
  ) {
    return 'Remember to apply for $roleName at $companyName.';
  }

  @override
  String get notificationChannelDraftRemindersName => 'Apply reminders';

  @override
  String get notificationChannelDraftRemindersDescription =>
      'Reminders for postings saved for later';

  @override
  String get labelApplicationStatus => 'Status';

  @override
  String get buttonSaveApplication => 'Save';

  @override
  String get applicationSaved => 'Application saved';

  @override
  String get applicationUrlRequired => 'Add a valid job link before saving.';

  @override
  String get applicationDetailTitle => 'Application';

  @override
  String get applicationOpenPosting => 'Open posting';

  @override
  String get applicationDelete => 'Delete';

  @override
  String get applicationDeleteConfirmTitle => 'Delete this application?';

  @override
  String get applicationDeleteConfirmBody => 'This cannot be undone.';

  @override
  String get applicationConfirmDelete => 'Delete';

  @override
  String get jobStatusDraft => 'Saved for later';

  @override
  String get jobStatusSubmitted => 'Applied';

  @override
  String get jobStatusNoResponseYet => 'No reply yet';

  @override
  String get jobStatusInterviewScheduled => 'Interview scheduled';

  @override
  String get jobStatusDecisionPending => 'Waiting on their decision';

  @override
  String get jobStatusClosedNotSelected => 'Moving on';

  @override
  String get jobStatusOfferAccepted => 'Offer accepted';

  @override
  String get archiveSemesterFirstHalf => '1st semester';

  @override
  String get archiveSemesterSecondHalf => '2nd semester';

  @override
  String get archiveUntitledRole => 'Applications';

  @override
  String archiveGroupDisplay(
    String jobTitle,
    String semesterLabel,
    String year,
  ) {
    return '$jobTitle - $semesterLabel $year';
  }

  @override
  String get hireAskJobHuntDoneTitle => 'Close your search?';

  @override
  String get hireAskJobHuntDoneBody =>
      'Are you done looking for a role for now?';

  @override
  String get hireJobHuntDoneNo => 'Still exploring';

  @override
  String get hireJobHuntDoneYes => 'Yes, I am done';

  @override
  String get hireCongratulationsTitle => 'Congratulations';

  @override
  String get hireCongratulationsBody =>
      'You earned this. Take a moment to enjoy the win.';

  @override
  String get hireAskDisposalTitle => 'Other applications';

  @override
  String get hireAskDisposalBody =>
      'What should we do with your other active applications?';

  @override
  String get hireKeepApplications => 'Keep them visible';

  @override
  String get hireArchiveApplications => 'Archive them';

  @override
  String get archiveReminderTitle => 'Let them know';

  @override
  String get archiveReminderBody =>
      'These applications are still waiting for a final answer. Consider sending a short note that you accepted another offer so everyone can move on cleanly.';

  @override
  String get archiveReminderEmptyList =>
      'None of your other applications are in the waiting-on-decision stage. You can still archive everything for a fresh start.';

  @override
  String get archiveConfirmArchive => 'Archive all others';

  @override
  String get commonOk => 'OK';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonClose => 'Close';

  @override
  String get sectionAppearance => 'Appearance';

  @override
  String get sectionLanguage => 'Language';

  @override
  String get labelBackground => 'Background';

  @override
  String get labelDisplayLanguage => 'Display language';

  @override
  String get appearanceSystem => 'System';

  @override
  String get appearanceWhite => 'White';

  @override
  String get appearanceBlack => 'Black';

  @override
  String get appearanceAmoledBlack => 'AMOLED black';

  @override
  String get languageSystem => 'System default';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageFrench => 'French';

  @override
  String get foundationBlurb =>
      'Theme and language apply everywhere in the app.';

  @override
  String applicationsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count applications',
      one: '1 application',
      zero: 'No applications yet',
    );
    return '$_temp0';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get profileSectionIdentity => 'Identity';

  @override
  String get profileSectionContact => 'Contact';

  @override
  String get profileSectionSocial => 'Social links';

  @override
  String get profileSectionResumes => 'Resumes';

  @override
  String get labelProfileDisplayName => 'Display name';

  @override
  String get labelProfileHeadline => 'Headline';

  @override
  String get labelProfileEmail => 'Email';

  @override
  String get labelProfilePhone => 'Phone';

  @override
  String get labelProfileBio => 'Bio';

  @override
  String get labelProfileGithub => 'GitHub URL';

  @override
  String get labelProfileGitlab => 'GitLab URL';

  @override
  String get labelProfileLinkedin => 'LinkedIn URL';

  @override
  String get labelProfileDribbble => 'Dribbble URL';

  @override
  String get labelProfileBehance => 'Behance URL';

  @override
  String get profileSave => 'Save';

  @override
  String get profileSaved => 'Profile saved';

  @override
  String get profileShare => 'Share profile card';

  @override
  String get profileShareSubject => 'Profile card';

  @override
  String get profileShareEmpty =>
      'Add your name, contact, or a social link before sharing.';

  @override
  String get profileInvalidUrl =>
      'That URL does not look valid. Check the field and try again.';

  @override
  String get profileAddResume => 'Add resume';

  @override
  String get profileOpenResume => 'Open';

  @override
  String get profileRemoveResume => 'Remove';

  @override
  String get profileResumeUnsupported =>
      'Saving resumes is not available on this platform.';

  @override
  String get profileResumeReadFailed => 'Could not read that file.';

  @override
  String get profileResumeWriteFailed => 'Could not save that file.';

  @override
  String get profileOpenResumeFailed => 'Could not open that file.';

  @override
  String get socialLinkGithub => 'GitHub';

  @override
  String get socialLinkGitlab => 'GitLab';

  @override
  String get socialLinkLinkedin => 'LinkedIn';

  @override
  String get socialLinkDribbble => 'Dribbble';

  @override
  String get socialLinkBehance => 'Behance';

  @override
  String get profileAddSocialLink => 'Add another link';

  @override
  String get profileRemoveSocialLink => 'Remove link';

  @override
  String get profileSocialLinksEmptyHint =>
      'Add portfolio or social links if you like.';

  @override
  String get profileUrlHint => 'https://';

  @override
  String get sectionSwipeShortcuts => 'List swipe shortcuts';

  @override
  String get settingsSwipeStartPaneLabel => 'Start-side card swipe';

  @override
  String get settingsSwipeStartPaneHint =>
      'Opens when you swipe outward on the leading edge of the card in your reading direction.';

  @override
  String get settingsSwipeEndPaneLabel => 'End-side card swipe';

  @override
  String get settingsSwipeEndPaneHint =>
      'Opens when you swipe outward on the trailing edge of the card in your reading direction.';

  @override
  String get swipeShortcutAdvanceLabel => 'Advance one stage';

  @override
  String applicationSwipeStatusUpdated(String statusLabel) {
    return 'Updated to $statusLabel.';
  }

  @override
  String get sectionFollowUpReminders => 'Follow-up reminders';

  @override
  String get settingsWaitingFollowUpDaysLabel =>
      'Waiting reply reminder (days)';

  @override
  String get settingsWaitingFollowUpDaysHint =>
      'For active applications in Applied or No reply yet, schedule a local reminder when the date is at least this many days old (3 to 30).';

  @override
  String get applicationsListMenuTooltip => 'More options';

  @override
  String get applicationsMenuImportCsv => 'Import CSV';

  @override
  String get csvImportParseFailed => 'Could not read that CSV file.';

  @override
  String get csvImportTitle => 'Import from CSV';

  @override
  String csvImportSummary(int importedCount, int skippedCount) {
    return 'Imported $importedCount. Skipped $skippedCount.';
  }

  @override
  String get csvImportNoRows => 'No rows to import.';

  @override
  String get csvImportHelpTitle => 'Expected columns';

  @override
  String get csvImportHelpBody =>
      'The first row should name columns. Supported headers include job link, URL, posting URL, title, role, company, date (YYYY-MM-DD), and optional status.';

  @override
  String get csvImportMissingHeaders => 'Could not find a job link column.';

  @override
  String get waitingFollowUpNotificationTitle => 'Follow up on an application';

  @override
  String waitingFollowUpNotificationBody(String roleName, String companyName) {
    return 'Check in on $roleName at $companyName.';
  }

  @override
  String get notificationChannelWaitingFollowUpsName =>
      'Waiting reply reminders';

  @override
  String get notificationChannelWaitingFollowUpsDescription =>
      'Nudges for applications still in Applied or No reply yet';

  @override
  String get sectionAppWallpaper => 'App backdrop';

  @override
  String get appWallpaperModeNone => 'Default';

  @override
  String get appWallpaperModeImage => 'Photo';

  @override
  String get appWallpaperModeGradient => 'Gradient';

  @override
  String get appWallpaperModeAnimated => 'Animated';

  @override
  String get appWallpaperChooseImage => 'Choose photo';

  @override
  String get appWallpaperClearImage => 'Remove photo';

  @override
  String get appWallpaperImageImportFailed =>
      'Could not use that image. Try another format.';

  @override
  String get appWallpaperStaticPresetsLabel => 'Gradient style';

  @override
  String get appWallpaperAnimatedPresetsLabel => 'Animated style';

  @override
  String get appWallpaperPresetOcean => 'Ocean';

  @override
  String get appWallpaperPresetSunset => 'Sunset';

  @override
  String get appWallpaperPresetTwilight => 'Twilight';

  @override
  String get appWallpaperPresetSage => 'Sage';

  @override
  String get appWallpaperPresetCoral => 'Coral';

  @override
  String get appWallpaperPresetGlacier => 'Glacier';

  @override
  String get appWallpaperPresetMidnight => 'Midnight';

  @override
  String get appWallpaperPresetLavender => 'Lavender';

  @override
  String get appWallpaperPresetRoseGold => 'Rose gold';

  @override
  String get appWallpaperPresetSandDune => 'Sand dune';

  @override
  String get appWallpaperPresetCherryMist => 'Cherry mist';

  @override
  String get appWallpaperAnimatedAurora => 'Aurora';

  @override
  String get appWallpaperAnimatedEmber => 'Ember';

  @override
  String get appWallpaperAnimatedNebula => 'Nebula';

  @override
  String get appWallpaperAnimatedPrism => 'Prism';

  @override
  String get appWallpaperAnimatedTide => 'Tide';

  @override
  String get appWallpaperAnimatedComet => 'Comet';

  @override
  String get appWallpaperAnimatedForge => 'Forge';

  @override
  String get appWallpaperAnimatedMeadow => 'Meadow';
}
