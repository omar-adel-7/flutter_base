import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:flutter_base/core/search/search_result_util.dart';


class CustomHtmlWidget extends StatefulWidget {

  final String html;
  final CustomStylesBuilder? customStylesBuilder;
  final CustomWidgetBuilder? customWidgetBuilder;
  final WidgetFactory Function()? factoryBuilder;
  final FutureOr<bool> Function(String url)? onTapUrl;
  final RenderMode renderMode;
  final TextStyle? textStyle;
  final GlobalKey<HtmlWidgetState>? widgetKey;

  const CustomHtmlWidget(this.html,
      {super.key,
      this.customStylesBuilder,
      this.customWidgetBuilder,
      this.factoryBuilder,
      this.onTapUrl,
      this.renderMode = RenderMode.column,
      this.textStyle,
      this.widgetKey});

  @override
  State<CustomHtmlWidget> createState() => _CustomHtmlWidgetState();
}

class _CustomHtmlWidgetState extends State<CustomHtmlWidget> {
  @override
  void initState() {
    super.initState();
    final bool isScrollToId =
        widget.html.contains(SearchResultUtil.HighlightSearchFirstMatchId);
    if (isScrollToId) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // wait until after the HTML content has been rendered
        // then request a scroll to the specified target
        await Future.delayed(const Duration(milliseconds: 1200));
        await widget.widgetKey?.currentState?.scrollToAnchor(SearchResultUtil.HighlightSearchFirstMatchId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      widget.html,
      customStylesBuilder: widget.customStylesBuilder,
      customWidgetBuilder: widget.customWidgetBuilder,
      factoryBuilder: widget.factoryBuilder,
      onTapUrl: (url) {
        if (url == "#${SearchResultUtil.HighlightSearchFirstMatchId}") {
          return false;
        } else if (widget.onTapUrl != null) {
          return widget.onTapUrl!(url);
        }
        return false;
      },
      renderMode: widget.renderMode,
      textStyle: widget.textStyle,
      key: widget.widgetKey ?? GlobalKey(),
    );
  }
}
