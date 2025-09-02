
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:flutter_widget_from_html_core/src/internal/core_ops.dart';

class JustifyTextWidgetFactory extends WidgetFactory {
  @override
  Widget? buildText(
      BuildTree tree, InheritedProperties resolved, InlineSpan text) {
    if (tree.overflow == TextOverflow.clip && text is TextSpan) {
      final textDirection = resolved.get<TextDirection>();
      return Text.rich(
        text,
        maxLines: tree.maxLines > 0 ? tree.maxLines : null,
        textAlign: TextAlign.justify,
        textDirection: textDirection,
      );
    }
    return super.buildText(tree, resolved, text);
  }
}
