import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_base/core/base_settings/data/language.dart';
import 'package:flutter_base/core/utils/base_app_utils.dart';

class BaseHiveStore {
  final Box box;

  BaseHiveStore({required this.box});

  static const String isNightModeKey = "isNightMode";
  static const String currentLanguageKey = "currentLanguage";

  static const String isFirstTimeKey = "isFirstTime";
  static const String isIntrokKey = "isIntro";
  static const String isNewVersionKey = "isNewVersion";
  static const String NewDatabasesCopiedKey = "NewDatabasesCopied";

  bool get copiedNewDatabases =>
      box.get(NewDatabasesCopiedKey, defaultValue: false);

  onCopiedNewDatabases() {
    box.put(NewDatabasesCopiedKey, true);
  }

  bool get isFirstTime => box.get(isFirstTimeKey, defaultValue: true);

  onFirstTimeChanged() {
    box.put(isFirstTimeKey, false);
  }

  bool get isNewVersion => box.get(isNewVersionKey, defaultValue: true);

  onNewVersionChanged() {
    box.put(isNewVersionKey, false);
  }

  Language get currentLanguage {
    try {
      // Attempt to retrieve the current language from the Hive box.
      final languageName = box.get(
        currentLanguageKey,
        defaultValue: Language.arabic.name,
      );
      return Language.values.byName(languageName);
    } catch (e) {
      // Handle any exceptions that occur during retrieval.
      customBaseLog('Error retrieving current language: $e');
      // Return the default value in case of an error.
      return Language.arabic;
    }
  }

  Future<void> updateCurrentLanguage(Language language) async {
    try {
      // Attempt to store the new language in the Hive box.
      await box.put(currentLanguageKey, language.name);
    } catch (e) {
      // Handle any exceptions that occur during the write operation.
      customBaseLog('Error updating current language: $e');
      // Optionally, rethrow the error or handle it accordingly.
      // throw e;
    }
  }

  bool get isNightModeEnabled {
    try {
      // Attempt to retrieve the night mode setting from the Hive box.
      return box.get(isNightModeKey, defaultValue: false);
    } catch (e) {
      // Handle any exceptions that occur during retrieval.
      customBaseLog('Error retrieving night mode setting: $e');
      // Return the default value in case of an error.
      return false;
    }
  }

  Future<void> updateNightModeSetting(bool isEnabled) async {
    try {
      // Attempt to store the new night mode setting in the Hive box.
      await box.put(isNightModeKey, isEnabled);
    } catch (e) {
      // Handle any exceptions that occur during the write operation.
      customBaseLog('Error updating night mode setting: $e');
      // Optionally, rethrow the error or handle it accordingly.
      // throw e;
    }
  }

}
