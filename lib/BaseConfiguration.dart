import 'package:flutter_base/core/base_settings/cubit/base_settings_cubit.dart';
import 'core/utils/BaseConstants.dart';

class BaseConfiguration {
  // Singleton pattern
  static final BaseConfiguration _instance = BaseConfiguration._internal();

  BaseConfiguration._internal();

  factory BaseConfiguration() => _instance;
  late BaseSettingsCubit baseSettingsCubit;
  String audioAndroidNotificationChannelId = "audio_channel_id";
  String databasesAssetsFolderName = "base_databases";
  String soundsAssetsFolderPath = "${BaseConstants.assetsFolder}/base_sounds/";
  String? baseDatabasesPassword;
  bool allowCancelDownload = false;
  double? htmlTextStyleWordSpacing = -2;
  double htmlTextStyleHeight = 2;
  int searchResultsItemTextMaxLines = 4;
  String searchTextHtmlHighlightedColor = '#FF2202';
}
