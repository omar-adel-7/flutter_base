part of 'base_settings_cubit.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class NightModeUpdated extends SettingsState {
  final bool isNightModeEnabled;
  NightModeUpdated(this.isNightModeEnabled);
}

class EmailSendingInProgress extends SettingsState {}

class EmailSendingSuccess extends SettingsState {}

/// Represents the state when an email sending process fails.
///
/// This state is emitted when an error occurs during the email sending process.
/// It includes an [errorMessage] to provide details about the failure.
class SettingsEmailError extends SettingsState {
}

class ReportErrorLoadingState extends SettingsState {}

class ReportErrorCompleteState extends SettingsState {}

class SettingsChangedState extends SettingsState {}

