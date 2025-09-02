import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:flutter_base/BaseConfiguration.dart';
import 'package:flutter_base/core/utils/BaseConstants.dart';
import '../ui_components/custom_html_widget.dart';
import '../utils/html_lines_count_widget_factory.dart';
import 'search_result_util.dart';

class SearchResultItemHtml extends StatelessWidget {
  String htmlText;
  final String searchText;
  final TextStyle htmlTextStyle;
  Function? customStyleBuilder ;
  TextAlign? htmlTextAlign;
  SearchResultItemHtml({
    super.key,
    required this.htmlText,
    required this.searchText,
    required this.htmlTextStyle,
    this.customStyleBuilder,
    this.htmlTextAlign,
  });

  @override
  Widget build(BuildContext context) {
    htmlText = SearchResultUtil.getHighlightedSearchedHtml(htmlText,searchText);
    return CustomHtmlWidget(
        htmlText,
        textStyle: htmlTextStyle.copyWith(
          wordSpacing: BaseConfiguration().htmlTextStyleWordSpacing,
          height: BaseConfiguration().htmlTextStyleHeight,
        ),
        customStylesBuilder: (element) {
          if (element.isHighlightedSearch) {
            return {'color': BaseConfiguration().searchTextHtmlHighlightedColor};
          }
          else
          {
            return customStyleBuilder != null
                ? customStyleBuilder!(context,element,htmlTextStyle.fontSize)
                : null;
          }
        },
        factoryBuilder: () =>
            HtmlLinesCountWidgetFactory(maxLines: BaseConfiguration().searchResultsItemTextMaxLines,textAlign: htmlTextAlign)
    );
  }
}

extension SearchResultElementExtesion on dom.Element {
  bool get isHighlightedSearch =>
      (localName == BaseConstants.spanTag) &&
          (classes.contains(SearchResultUtil.HighlightSearchClass));
}
