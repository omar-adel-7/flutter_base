import 'package:flutter/material.dart';

import 'custom_icon.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final Color? color;
  final GestureTapCallback? onTap;
  const CustomIconButton({
    super.key,
    required this.icon,
    this.iconSize,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: CustomIcon(
        icon: icon,
        color: color,
        size: iconSize ?? 30,
        isEnable: onTap != null,
      ),
    );
  }
}

class CustomIconButton2 extends StatelessWidget {
  final Color? color;
  final IconData icon;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry? padding;
  const CustomIconButton2({
    super.key,
    required this.icon,
    this.color,
    this.onTap,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: CustomIcon(
          icon: icon,
          color: color,
          padding: padding,
          isEnable: onTap != null,
        ),
      ),
    );
  }
}


