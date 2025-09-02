import 'package:flutter/material.dart';
import 'package:flutter_base/core/extension/base_extensions.dart';

class EffectiveOrientationBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, Orientation orientation)
  builder;

  const EffectiveOrientationBuilder({required this.builder, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = context.orientation;
    return builder(context, orientation);
  }
}