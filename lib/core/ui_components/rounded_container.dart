import 'package:flutter/material.dart';
class RoundedContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? radius;
  final Color? background;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  const RoundedContainer({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.background,
    this.borderRadius,
    this.boxShadow,
    this.radius,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        color: background ?? Colors.transparent,
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 10),
      ),
      child: child,
    );
  }
}
