import 'package:job_application_tracker/core/settings/app_background_presets.dart';
import 'package:job_application_tracker/l10n/app_localizations.dart';

extension AppWallpaperPresetL10n on String {
  String wallpaperPresetLabel(AppLocalizations l10n) {
    return switch (this) {
      AppBackgroundPresets.oceanId => l10n.appWallpaperPresetOcean,
      AppBackgroundPresets.sunsetId => l10n.appWallpaperPresetSunset,
      AppBackgroundPresets.twilightId => l10n.appWallpaperPresetTwilight,
      AppBackgroundPresets.sageId => l10n.appWallpaperPresetSage,
      AppBackgroundPresets.coralId => l10n.appWallpaperPresetCoral,
      AppBackgroundPresets.glacierId => l10n.appWallpaperPresetGlacier,
      AppBackgroundPresets.midnightId => l10n.appWallpaperPresetMidnight,
      AppBackgroundPresets.lavenderId => l10n.appWallpaperPresetLavender,
      AppBackgroundPresets.roseGoldId => l10n.appWallpaperPresetRoseGold,
      AppBackgroundPresets.sandDuneId => l10n.appWallpaperPresetSandDune,
      AppBackgroundPresets.cherryMistId => l10n.appWallpaperPresetCherryMist,
      AppBackgroundPresets.auroraId => l10n.appWallpaperAnimatedAurora,
      AppBackgroundPresets.emberId => l10n.appWallpaperAnimatedEmber,
      AppBackgroundPresets.nebulaId => l10n.appWallpaperAnimatedNebula,
      AppBackgroundPresets.prismId => l10n.appWallpaperAnimatedPrism,
      AppBackgroundPresets.tideId => l10n.appWallpaperAnimatedTide,
      AppBackgroundPresets.cometId => l10n.appWallpaperAnimatedComet,
      AppBackgroundPresets.forgeId => l10n.appWallpaperAnimatedForge,
      AppBackgroundPresets.meadowId => l10n.appWallpaperAnimatedMeadow,
      _ => this,
    };
  }
}
