
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:flutter_widget_from_html_core/src/internal/core_ops.dart';

class HtmlLinesCountWidgetFactory extends WidgetFactory {
  final int maxLines;
  final TextAlign? textAlign;

  HtmlLinesCountWidgetFactory({required this.maxLines, this.textAlign});

  @override
  Widget? buildText(
      BuildTree tree, InheritedProperties resolved, InlineSpan text) {
    tree.maxLines = maxLines;
    tree.overflow = TextOverflow.clip;
    if (text is TextSpan) {
      final textDirection = resolved.get<TextDirection>();
      return Text.rich(
        text,
        maxLines: maxLines,
        textAlign: textAlign ?? resolved.get<TextAlign>() ?? TextAlign.justify,
        textDirection: textDirection,
      );
    }
    return super.buildText(tree, resolved, text);
  }
}
