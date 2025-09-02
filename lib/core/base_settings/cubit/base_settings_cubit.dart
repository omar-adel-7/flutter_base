import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/core/base_settings/data/language.dart';
import 'package:flutter_base/core/base_settings/data/base_settings_repository.dart';

part 'settings_state.dart';

abstract class BaseSettingsCubit
    extends Cubit<SettingsState> {

  BaseSettingsCubit({
    required this.baseSettingsRepository,
    required SettingsState initialState,
  }) : super(initialState);

  final BaseSettingsRepository baseSettingsRepository;

  bool get isFirstTime => baseSettingsRepository.isFirstTime;

  bool get isNewVersion => baseSettingsRepository.isNewVersion;

  Language get currentLanguage => baseSettingsRepository.currentLanguage;

  bool get isArabic =>
      baseSettingsRepository.isArabic;

  Future<void> updateCurrentLanguage(Language language) async {
    baseSettingsRepository.updateCurrentLanguage(language);
  }

  // ------------------------- Night Mode Settings -------------------------

  bool get isNightModeEnabled => baseSettingsRepository.isNightModeEnabled;

  Future<void> updateNightModeSetting(bool isEnabled) async {
    await baseSettingsRepository.updateNightModeSetting(isEnabled);
    emit(NightModeUpdated(isEnabled));
  }

}

