import 'package:flutter_base/core/base_locales/base_app_localized.dart';
import 'package:flutter_base/core/cache/base_hive_store.dart';

import 'language.dart';


class BaseSettingsRepository  {
  final BaseHiveStore _baseHiveStore;

  BaseSettingsRepository({required BaseHiveStore baseHiveStore})
      : _baseHiveStore = baseHiveStore;

  bool get isFirstTime => _baseHiveStore.isFirstTime;
  bool get isNewVersion => _baseHiveStore.isNewVersion;

  Language get currentLanguage => _baseHiveStore.currentLanguage;

  bool get isArabic => currentLanguage.locale.languageCode ==
      BaseAppLocalized.arabicCode;

  Future<void> updateCurrentLanguage(Language language) =>
      _baseHiveStore.updateCurrentLanguage(language);


  bool get isNightModeEnabled => _baseHiveStore.isNightModeEnabled;

  Future<void> updateNightModeSetting(bool isEnabled) =>
      _baseHiveStore.updateNightModeSetting(isEnabled);

}
