import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/ui_components/fraction_size_box.dart';
import 'package:html/parser.dart';
import 'package:flutter_base/core/utils/base_app_utils.dart';

import '../../BaseConfiguration.dart';

extension RectExtension on Rect {
  Rect applyScale(double scale) {
    return Rect.fromLTRB(
      left * scale,
      top * scale,
      right * scale,
      bottom * scale,
    );
  }
}

enum DeviceType { Phone, Tablet }

extension MediaQueryHinge on MediaQueryData {
  DisplayFeature? get hasHinge {
    for (final DisplayFeature e in displayFeatures) {
      if (e.type == DisplayFeatureType.hinge) {
        return e;
      }
    }
    return null;
  }

  DisplayFeature? get hasCutout {
    for (final DisplayFeature e in displayFeatures) {
      if (e.type == DisplayFeatureType.cutout) {
        return e;
      }
    }
    return null;
  }

  DisplayFeature? get hasFold {
    for (final DisplayFeature e in displayFeatures) {
      if (e.type == DisplayFeatureType.fold) {
        return e;
      }
    }
    return null;
  }

  DisplayFeatureState? get displayFeatureState {
    for (final DisplayFeature e in displayFeatures) {
      if (e.type == DisplayFeatureType.fold) {
        return e.state;
      }
    }
    return null;
  }
}

extension BaseBuildContextExtension on BuildContext {
  MediaQueryData get mediaQueryData {
    return MediaQuery.of(this);
    // return MediaQueryData.fromView(
    //   View.of(this),
    // ); //wrong as it will not rebuild the widget when changes
  }

  Size get mediaQuerySize {
    return mediaQueryData.size;
  }

  double get height {
    return mediaQuerySize.height;
  }

  double get width {
    return mediaQuerySize.width;
  }

  bool isWidthHalfScreen(double maxWidgetAvailableWidth) {
    customBaseLog(
      "isWidthHalfScreen maxWidgetAvailableWidth $maxWidgetAvailableWidth",
    );
    customBaseLog("isWidthHalfScreen width $width");
    return (maxWidgetAvailableWidth * 2) <= width;
  }

  Orientation get orientation {
    return width > height ? Orientation.landscape : Orientation.portrait;
  }

  bool get isPortrait {
    return orientation == Orientation.portrait;
  }

  bool get isLandscape {
    return orientation == Orientation.landscape;
  }

  bool get isPhoneLandscape {
    return isPhone && isLandscape;
  }

  bool get isTabletLandscape {
    return isTablet && isLandscape;
  }


  DeviceType get deviceType {
    return mediaQuerySize.shortestSide < 550
        ? DeviceType.Phone
        : DeviceType.Tablet;
  }

  bool get hasCutout {
    return mediaQueryData.hasCutout != null;
  }

  bool get hasHinge {
    return mediaQueryData.hasHinge != null;
  }

  bool get hasFold {
    return mediaQueryData.hasFold != null;
  }

  DisplayFeatureState? get displayFeatureState {
    return mediaQueryData.displayFeatureState;
  }

  bool get isFoldOpened {
    return displayFeatureState == DisplayFeatureState.postureFlat;
  }

  bool get isFoldHalfOpened {
    return displayFeatureState == DisplayFeatureState.postureHalfOpened;
  }

  bool get hasNotch {
    final padding = View.of(this).viewPadding;
    bool result = padding.top > 0 || padding.bottom > 0;
    return result;
  }

  bool get isPhone {
    return deviceType == DeviceType.Phone;
  }

  bool get isSmallPhone {
    return mediaQuerySize.shortestSide < 380;
  }

  bool get isTablet {
    return deviceType == DeviceType.Tablet;
  }

  String get languageCode => BaseConfiguration()
      .baseSettingsCubit
      .currentLanguage
      .locale
      .languageCode;

  bool get isNightMode =>
      BaseConfiguration().baseSettingsCubit.isNightModeEnabled;
}

extension StringEx on String {
  // Get the file name with extension from the path
  String get fileName => split('/').last;

  // Get the file name without extension from the path
  String get fileNameWithoutExtension => split('/').last.split('.').first;

  // Get the file extension from the file name
  String get fileExtension => split('.').last;

  String removeHtmlIfFound() {
    String text = replaceAll("<br>", '\n');
    final document = parse(text);
    return parse(document.body?.text).documentElement?.text ?? "";
  }
}

extension StringExtension on String? {
  /// Returns true if given String is null or isEmpty
  bool get isEmptyOrNull =>
      this == null ||
      (this != null && this!.isEmpty) ||
      (this != null && this! == 'null');

  // Check null string, return given value if null
  String validate({String value = ''}) {
    if (isEmptyOrNull) {
      return value;
    } else {
      return this!;
    }
  }

  /// Return true if given String is Digit
  bool isDigit() {
    if (validate().isEmpty) {
      return false;
    }
    if (validate().length > 1) {
      for (var r in this!.runes) {
        if (r ^ 0x30 > 9) {
          return false;
        }
      }
      return true;
    } else {
      return this!.runes.first ^ 0x30 <= 9;
    }
  }

  /// Return int value of given string
  int toInt({int defaultValue = 0}) {
    if (this == null) return defaultValue;

    if (isDigit()) {
      return int.parse(this!);
    } else {
      return defaultValue;
    }
  }

  /// Return double value of given string
  double toDouble({double defaultValue = 0.0}) {
    if (this == null) return defaultValue;
    try {
      return double.parse(this!);
    } catch (e) {
      return defaultValue;
    }
  }
}

extension IterableJoinToString<E> on Iterable<E> {
  String joinToString({String separator = ', '}) {
    final buffer = StringBuffer();
    var count = 0;
    for (final element in this) {
      if (count > 0) {
        buffer.write(separator);
      }
      buffer.write(element.toString());
      count++;
    }
    return buffer.toString();
  }
}

extension SP on double {
  toValue(BuildContext context) {
    if (context.isPhone) {
      return this;
    } else {
      return this + 7;
    }
  }
}

extension BaseLocalBuildContextExtension on BuildContext {
  bool get isBaseAppLanguageArabic =>
      BaseConfiguration().baseSettingsCubit.isArabic;

  Locale get locale => Localizations.localeOf(this);
}

extension BaseBuildContextBottomSheetExtension on BuildContext {
  Future<T?> showBottomSheetModal<T>({
    Color? backgroundColor,
    bool useRootNavigator = false,
    ShapeBorder? shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
    ),
    bool useFraction = false,
    double? portraitHeightFactor,
    double? landscapeHeightFactor,
    bool isLandscapeTabletHeightSmall =
        FractionSizeBox.defaultIsLandscapeTabletHeightSmall,
    required Widget widget,
  }) {
    return showModalBottomSheet<T>(
      backgroundColor: backgroundColor,
      shape: shape,
      context: this,
      builder: (BuildContext context) => Padding(
        padding: MediaQuery.viewInsetsOf(context),
        child: useFraction
            ? FractionSizeBox(
                portraitHeightFactor: portraitHeightFactor,
                landscapeHeightFactor: landscapeHeightFactor,
                isLandscapeTabletHeightSmall: isLandscapeTabletHeightSmall,
                widget: widget,
              )
            : widget,
      ),
      useRootNavigator: useRootNavigator,
      isScrollControlled: true,
    );
  }
}
