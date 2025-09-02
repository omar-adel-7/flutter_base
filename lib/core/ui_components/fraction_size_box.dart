
import 'package:flutter/material.dart';
import 'package:flutter_base/core/extension/base_extensions.dart';

class FractionSizeBox extends StatelessWidget {
  static const bool defaultIsLandscapeTabletHeightSmall = false;
  final double? portraitHeightFactor;
  final double? landscapeHeightFactor;
  final bool isLandscapeTabletHeightSmall;
  final Widget widget;

  const FractionSizeBox({
    super.key,
    this.portraitHeightFactor,
    this.landscapeHeightFactor,
    required this.isLandscapeTabletHeightSmall,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    bool isTablet = context.isTablet;
    bool isPortrait = context.isPortrait;
    return FractionallySizedBox(
        heightFactor: isPortrait
            ? (portraitHeightFactor ?? 0.92) * (isTablet ? 0.84 : 1)
            : (landscapeHeightFactor ?? 0.92) *
                ((isTablet && isLandscapeTabletHeightSmall)
                    ? 0.6
                    : isTablet
                        ? 0.9
                        : 1),
        widthFactor: isPortrait ? 1.0 : 0.92,
        child: widget);
  }
}
