import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final bool isEnable;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  const CustomIcon({
    super.key,
    this.size,
    required this.icon,
    required this.isEnable,
    this.color,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(10),
      child: Icon(
        icon,
        size: size ?? 20,
        color: isEnable ? color : Colors.grey.withValues(alpha: 0.3),
      ),
    );
  }
}
