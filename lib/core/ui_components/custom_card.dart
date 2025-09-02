import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Color? color;
  final Color? surfaceTintColor;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final Widget? child;

  const CustomCard({
    super.key,
    this.color,
    this.surfaceTintColor,
    this.margin,
    this.elevation,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? Colors.transparent,
      surfaceTintColor: surfaceTintColor ?? Colors.transparent,
      margin: margin ?? EdgeInsets.zero,
      elevation: elevation ?? 0,
      child: child,
    );
  }
}
