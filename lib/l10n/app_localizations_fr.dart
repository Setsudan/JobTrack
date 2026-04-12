// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'JobTrack';

  @override
  String get navHome => 'Accueil';

  @override
  String get navApplications => 'Candidatures';

  @override
  String get navNewApplication => 'Nouveau';

  @override
  String get navProfile => 'Profil';

  @override
  String get profileTitle => 'Profil';

  @override
  String get homeWelcomeTitle => 'Votre recherche, structurée';

  @override
  String get homeWelcomeSubtitle =>
      'Liens, dates et résultats au même endroit, sans surcharge.';

  @override
  String get homeStatsSectionTitle => 'Vue d\'ensemble';

  @override
  String get homeStatActiveTitle => 'Actives';

  @override
  String get homeStatWaitingTitle => 'En attente de retour';

  @override
  String get homeStatInterviewTitle => 'Entretiens';

  @override
  String get homeStatArchivedTitle => 'Archives';

  @override
  String get homeRecentApplications => 'Modifiées récemment';

  @override
  String get homeViewAllApplications => 'Tout voir';

  @override
  String get applicationsListTitle => 'Candidatures';

  @override
  String get applicationsActiveTab => 'Actives';

  @override
  String get applicationsArchivedTab => 'Archives';

  @override
  String get applicationsEmptyActive =>
      'Aucune candidature active. Ajoutez-en via Nouveau.';

  @override
  String get applicationsEmptyArchived => 'Aucune candidature archivée.';

  @override
  String get applicationCreateTitle => 'Nouvelle candidature';

  @override
  String get labelJobPostingUrl => 'Lien de l\'offre';

  @override
  String get hintJobPostingUrl => 'Collez l\'URL de l\'annonce';

  @override
  String get buttonFetchJobDetails => 'Charger les infos depuis le lien';

  @override
  String get jobMetadataFetchFailed =>
      'Impossible de lire les détails de ce lien. Vous pouvez remplir les champs manuellement.';

  @override
  String get jobMetadataNothingFound =>
      'Aucun intitulé détecté. Saisissez le poste et l\'entreprise vous-même.';

  @override
  String get labelJobTitle => 'Poste';

  @override
  String get labelCompanyName => 'Entreprise';

  @override
  String get labelDateSubmitted => 'Date d\'envoi';

  @override
  String get labelReminderToApplyDate => 'Rappel pour postuler';

  @override
  String get draftApplyReminderNotificationTitle => 'Rappel de candidature';

  @override
  String draftApplyReminderNotificationBody(
    String roleName,
    String companyName,
  ) {
    return 'Pensez à postuler pour $roleName chez $companyName.';
  }

  @override
  String get notificationChannelDraftRemindersName => 'Rappels de candidature';

  @override
  String get notificationChannelDraftRemindersDescription =>
      'Rappels pour les offres enregistrées pour plus tard';

  @override
  String get labelApplicationStatus => 'Statut';

  @override
  String get buttonSaveApplication => 'Enregistrer';

  @override
  String get applicationSaved => 'Candidature enregistrée';

  @override
  String get applicationUrlRequired =>
      'Ajoutez un lien d\'offre valide avant d\'enregistrer.';

  @override
  String get applicationDetailTitle => 'Candidature';

  @override
  String get applicationOpenPosting => 'Ouvrir l\'annonce';

  @override
  String get applicationDelete => 'Supprimer';

  @override
  String get applicationDeleteConfirmTitle => 'Supprimer cette candidature ?';

  @override
  String get applicationDeleteConfirmBody => 'Cette action est définitive.';

  @override
  String get applicationConfirmDelete => 'Supprimer';

  @override
  String get jobStatusDraft => 'Enregistrée, pas encore envoyée';

  @override
  String get jobStatusSubmitted => 'Candidature envoyée';

  @override
  String get jobStatusNoResponseYet => 'Pas de retour pour l\'instant';

  @override
  String get jobStatusInterviewScheduled => 'Entretien planifié';

  @override
  String get jobStatusDecisionPending => 'En attente de leur décision';

  @override
  String get jobStatusClosedNotSelected => 'Je passe à autre chose';

  @override
  String get jobStatusOfferAccepted => 'Offre acceptée';

  @override
  String get archiveSemesterFirstHalf => '1er semestre';

  @override
  String get archiveSemesterSecondHalf => '2e semestre';

  @override
  String get archiveUntitledRole => 'Candidatures';

  @override
  String archiveGroupDisplay(
    String jobTitle,
    String semesterLabel,
    String year,
  ) {
    return '$jobTitle - $semesterLabel $year';
  }

  @override
  String get hireAskJobHuntDoneTitle => 'Mettre votre recherche en pause ?';

  @override
  String get hireAskJobHuntDoneBody =>
      'Souhaitez-vous indiquer que vous avez terminé votre recherche pour le moment ?';

  @override
  String get hireJobHuntDoneNo => 'Je continue à chercher';

  @override
  String get hireJobHuntDoneYes => 'Oui, c\'est terminé';

  @override
  String get hireCongratulationsTitle => 'Félicitations';

  @override
  String get hireCongratulationsBody =>
      'Profitez de ce moment : c\'est le fruit de votre travail.';

  @override
  String get hireAskDisposalTitle => 'Autres candidatures';

  @override
  String get hireAskDisposalBody =>
      'Que faire de vos autres candidatures actives ?';

  @override
  String get hireKeepApplications => 'Les garder visibles';

  @override
  String get hireArchiveApplications => 'Les archiver';

  @override
  String get archiveReminderTitle => 'Prévenir les recruteurs';

  @override
  String get archiveReminderBody =>
      'Ces candidatures attendent encore une réponse finale. Pensez à prévenir que vous avez accepté une autre offre, pour clôturer proprement.';

  @override
  String get archiveReminderEmptyList =>
      'Aucune autre candidature n\'est en attente de décision. Vous pouvez quand même archiver le reste pour repartir à zéro.';

  @override
  String get archiveConfirmArchive => 'Archiver toutes les autres';

  @override
  String get commonOk => 'OK';

  @override
  String get commonContinue => 'Continuer';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonClose => 'Fermer';

  @override
  String get sectionAppearance => 'Apparence';

  @override
  String get sectionLanguage => 'Langue';

  @override
  String get labelBackground => 'Arrière-plan';

  @override
  String get labelDisplayLanguage => 'Langue d\'affichage';

  @override
  String get appearanceSystem => 'Système';

  @override
  String get appearanceWhite => 'Blanc';

  @override
  String get appearanceBlack => 'Noir';

  @override
  String get appearanceAmoledBlack => 'Noir AMOLED';

  @override
  String get languageSystem => 'Langue du système';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageFrench => 'Français';

  @override
  String get foundationBlurb =>
      'Le thème et la langue s\'appliquent partout dans l\'application.';

  @override
  String applicationsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count candidatures',
      one: '1 candidature',
      zero: 'Aucune candidature',
    );
    return '$_temp0';
  }

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get profileSectionIdentity => 'Identité';

  @override
  String get profileSectionContact => 'Contact';

  @override
  String get profileSectionSocial => 'Réseaux sociaux';

  @override
  String get profileSectionResumes => 'CV';

  @override
  String get labelProfileDisplayName => 'Nom affiché';

  @override
  String get labelProfileHeadline => 'Titre';

  @override
  String get labelProfileEmail => 'E-mail';

  @override
  String get labelProfilePhone => 'Téléphone';

  @override
  String get labelProfileBio => 'Bio';

  @override
  String get labelProfileGithub => 'URL GitHub';

  @override
  String get labelProfileGitlab => 'URL GitLab';

  @override
  String get labelProfileLinkedin => 'URL LinkedIn';

  @override
  String get labelProfileDribbble => 'URL Dribbble';

  @override
  String get labelProfileBehance => 'URL Behance';

  @override
  String get profileSave => 'Enregistrer';

  @override
  String get profileSaved => 'Profil enregistré';

  @override
  String get profileShare => 'Partager la carte de profil';

  @override
  String get profileShareSubject => 'Carte de profil';

  @override
  String get profileShareEmpty =>
      'Ajoutez votre nom, un contact ou un lien social avant de partager.';

  @override
  String get profileInvalidUrl =>
      'Cette URL ne semble pas valide. Vérifiez le champ.';

  @override
  String get profileAddResume => 'Ajouter un CV';

  @override
  String get profileOpenResume => 'Ouvrir';

  @override
  String get profileRemoveResume => 'Supprimer';

  @override
  String get profileResumeUnsupported =>
      'L\'enregistrement des CV n\'est pas disponible sur cette plateforme.';

  @override
  String get profileResumeReadFailed => 'Impossible de lire ce fichier.';

  @override
  String get profileResumeWriteFailed =>
      'Impossible d\'enregistrer ce fichier.';

  @override
  String get profileOpenResumeFailed => 'Impossible d\'ouvrir ce fichier.';

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
  String get profileAddSocialLink => 'Ajouter un lien';

  @override
  String get profileRemoveSocialLink => 'Retirer le lien';

  @override
  String get profileSocialLinksEmptyHint =>
      'Ajoutez des liens professionnels si vous le souhaitez.';

  @override
  String get profileUrlHint => 'https://';

  @override
  String get sectionSwipeShortcuts => 'Raccourcis de balayage';

  @override
  String get settingsSwipeStartPaneLabel => 'Balayage côté début';

  @override
  String get settingsSwipeStartPaneHint =>
      'S\'ouvre quand vous balayez vers l\'extérieur depuis le bord de début de la carte.';

  @override
  String get settingsSwipeEndPaneLabel => 'Balayage côté fin';

  @override
  String get settingsSwipeEndPaneHint =>
      'S\'ouvre quand vous balayez vers l\'extérieur depuis le bord opposé.';

  @override
  String get swipeShortcutAdvanceLabel => 'Avancer d\'une étape';

  @override
  String applicationSwipeStatusUpdated(String statusLabel) {
    return 'Mis à jour : $statusLabel.';
  }

  @override
  String get sectionFollowUpReminders => 'Rappels de suivi';

  @override
  String get settingsWaitingFollowUpDaysLabel => 'Rappel sans réponse (jours)';

  @override
  String get settingsWaitingFollowUpDaysHint =>
      'Pour les candidatures actives en « Postulé » ou « Pas encore de réponse », planifier un rappel local lorsque la date a au moins cet âge (3 à 30 jours).';

  @override
  String get applicationsListMenuTooltip => 'Plus d\'options';

  @override
  String get applicationsMenuImportCsv => 'Importer un CSV';

  @override
  String get csvImportParseFailed => 'Impossible de lire ce fichier CSV.';

  @override
  String get csvImportTitle => 'Importer depuis un CSV';

  @override
  String csvImportSummary(int importedCount, int skippedCount) {
    return 'Importées : $importedCount. Ignorées : $skippedCount.';
  }

  @override
  String get csvImportNoRows => 'Aucune ligne à importer.';

  @override
  String get csvImportHelpTitle => 'Colonnes attendues';

  @override
  String get csvImportHelpBody =>
      'La première ligne nomme les colonnes. En-têtes pris en charge : lien d\'offre, URL, titre, rôle, entreprise, date (AAAA-MM-JJ), statut (facultatif).';

  @override
  String get csvImportMissingHeaders =>
      'Impossible de trouver une colonne de lien d\'offre.';

  @override
  String get waitingFollowUpNotificationTitle => 'Relancer une candidature';

  @override
  String waitingFollowUpNotificationBody(String roleName, String companyName) {
    return 'Pensez à $roleName chez $companyName.';
  }

  @override
  String get notificationChannelWaitingFollowUpsName => 'Rappels sans réponse';

  @override
  String get notificationChannelWaitingFollowUpsDescription =>
      'Rappels pour les candidatures toujours en attente de l\'employeur';

  @override
  String get sectionAppWallpaper => 'Arrière-plan de l\'app';

  @override
  String get appWallpaperModeNone => 'Par défaut';

  @override
  String get appWallpaperModeImage => 'Photo';

  @override
  String get appWallpaperModeGradient => 'Dégradé';

  @override
  String get appWallpaperModeAnimated => 'Animé';

  @override
  String get appWallpaperChooseImage => 'Choisir une photo';

  @override
  String get appWallpaperClearImage => 'Retirer la photo';

  @override
  String get appWallpaperImageImportFailed =>
      'Impossible d\'utiliser cette image. Essayez un autre format.';

  @override
  String get appWallpaperCropTitle => 'Placer la photo';

  @override
  String get appWallpaperCropHint =>
      'Faites glisser pour déplacer la photo. Pincez pour zoomer. Le cadre correspond à la forme de l\'écran.';

  @override
  String get appWallpaperCropApply => 'Utiliser en arrière-plan';

  @override
  String get appWallpaperCropFailed =>
      'Impossible d\'appliquer ce recadrage. Réessayez.';

  @override
  String get appWallpaperStaticPresetsLabel => 'Style de dégradé';

  @override
  String get appWallpaperAnimatedPresetsLabel => 'Style animé';

  @override
  String get appWallpaperPresetOcean => 'Océan';

  @override
  String get appWallpaperPresetSunset => 'Coucher de soleil';

  @override
  String get appWallpaperPresetTwilight => 'Crépuscule';

  @override
  String get appWallpaperPresetSage => 'Sauge';

  @override
  String get appWallpaperPresetCoral => 'Corail';

  @override
  String get appWallpaperPresetGlacier => 'Glacier';

  @override
  String get appWallpaperPresetMidnight => 'Minuit';

  @override
  String get appWallpaperPresetLavender => 'Lavande';

  @override
  String get appWallpaperPresetRoseGold => 'Or rose';

  @override
  String get appWallpaperPresetSandDune => 'Dune';

  @override
  String get appWallpaperPresetCherryMist => 'Brume cerise';

  @override
  String get appWallpaperAnimatedAurora => 'Aurore';

  @override
  String get appWallpaperAnimatedEmber => 'Braise';

  @override
  String get appWallpaperAnimatedNebula => 'Nébuleuse';

  @override
  String get appWallpaperAnimatedPrism => 'Prisme';

  @override
  String get appWallpaperAnimatedTide => 'Marée';

  @override
  String get appWallpaperAnimatedComet => 'Comète';

  @override
  String get appWallpaperAnimatedForge => 'Forge';

  @override
  String get appWallpaperAnimatedMeadow => 'Prairie';

  @override
  String get startupFailureTitle => 'Impossible de démarrer JobTrack';

  @override
  String get startupFailureBody =>
      'Un problème est survenu au chargement de vos données. Les détails ont été enregistrés dans un fichier journal sur cet appareil.';

  @override
  String get startupFailureLogPathLabel => 'Chemin du fichier journal';

  @override
  String get startupFailureTechnicalHint => 'Résumé technique';
}
