import 'dart:ui';

enum Language {
  arabic,
  english;

  static List<Locale> get supportedLocales =>
      Language.values.map((item) => item.locale).toList();

  Locale get locale {
    switch (this) {
      case Language.arabic:
        return const Locale('ar');
      case Language.english:
        return const Locale('en');
    }
  }
}
