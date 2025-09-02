
import 'package:flutter/material.dart';
import 'package:flutter_base/BaseConfiguration.dart';

class SearchResultUtil {
  static String HighlightSearchClass = "highlight_search";
  static String HighlightSearchFirstMatchId = "highlight_search_id";

  static Widget getDisplayedTextWithSearch(
      BuildContext context,
      String text,
      String searchText,
      TextStyle contentStyle,
      bool isSearchInDatabase,
      {Color? spanHighlightColor,
      Function? customHtmlStyleBuilder,
      TextAlign? htmlTextAlign}) {
      RegExp regEx = getSrchRegix(searchText, isSearchInDatabase);
      SearchHighlightNormalTextResultModel searchHighlightNormalTextResult =
          getNormalTextHighlightResult(text, regEx);
      return searchResultAsSpans(context, searchHighlightNormalTextResult,
          contentStyle, spanHighlightColor);
  }

  static RegExp getSrchRegix(String searchText, bool isSearchInDatabase) {
    String regEx = "";
    if (isSearchInDatabase) {
      String regex1 = "[أآإا]";
      String regex2 = "[ئءؤء]";
      String regex3 = "[ىي]";
      String regex4 = "[ةه]";
      for (int i = 0; i < searchText.length; i++) {
        regEx += "${searchText[i]}[ًٌٍَُِّْ]*";
      }
      regEx = regEx.replaceAll("ا", regex1);
      regEx = regEx.replaceAll("ء", regex2);
      regEx = regEx.replaceAll("ي", regex3);
      regEx = regEx.replaceAll("ه", regex4);
    } else {
      regEx = searchText;
    }
    return RegExp(regEx, caseSensitive: false); //searchText only
    //return RegExp("(\\S*|<|/>)$regEx(\\S*|<|/>)", caseSensitive: false); //
  }

  static Widget searchResultAsSpans(
      BuildContext context,
      SearchHighlightNormalTextResultModel searchHighlightNormalTextResult,
      TextStyle contentStyle,
      Color? highlightColor) {
    List<TextSpan> textSpans = [];
    for (int i = 0; i < searchHighlightNormalTextResult.textParts.length; i++) {
      if (searchHighlightNormalTextResult.matchedSearchIndexesInTextParts
          .contains(i)) {
        textSpans.add(TextSpan(
            text: searchHighlightNormalTextResult.textParts[i],
            style: contentStyle.copyWith(color: highlightColor).copyWith(
                  wordSpacing: BaseConfiguration().htmlTextStyleWordSpacing,
                  height: BaseConfiguration().htmlTextStyleHeight,
                )));
      } else {
        textSpans.add(TextSpan(
          text: searchHighlightNormalTextResult.textParts[i],
        ));
      }
    }
    return RichText(
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.justify,
      maxLines: BaseConfiguration().searchResultsItemTextMaxLines,
      text: TextSpan(
        style: contentStyle.copyWith(
          wordSpacing: BaseConfiguration().htmlTextStyleWordSpacing,
          height: BaseConfiguration().htmlTextStyleHeight,
        ),
        children: textSpans,
      ),
    );
  }


  static SearchHighlightNormalTextResultModel getNormalTextHighlightResult(
      String text, RegExp regEx) {
    List<String> textParts = [];
    List<int> matchedSearchIndexesInTextParts = [];
    var lastEnd = 0;
    for (final match in regEx.allMatches(text)) {
      if (match.start > lastEnd) {
        textParts.add(
          text.substring(lastEnd, match.start),
        );
      }
      textParts.add(
        text.substring(match.start, match.end),
      );
      matchedSearchIndexesInTextParts.add(textParts.length - 1);
      lastEnd = match.end;
    }
    if (lastEnd < text.length) {
      textParts.add(
        text.substring(lastEnd),
      );
    }
    return SearchHighlightNormalTextResultModel(
        textParts: textParts,
        matchedSearchIndexesInTextParts: matchedSearchIndexesInTextParts);
  }

  static String getTextBesideSearch(
      String text, String searchText, bool isSearchInDatabase) {
    RegExp regEx = getSrchRegix(searchText, isSearchInDatabase);
    String shTxt = "";
    final match = regEx.firstMatch(text);
    String? g0 = match?.group(0);
    if (g0 != null) {
      int index = text.indexOf(g0, 0);
      if (index > 70) {
        if (text.length > index + 150) {
          shTxt = text.substring(index - 30, index + 150);
        } else {
          shTxt = text.substring(index, text.length);
        }
      } else {
        if (text.length > index + 150) {
          shTxt = text.substring(index, index + 150);
        } else {
          shTxt = text.substring(index, text.length);
        }
      }
    }
    return shTxt;
  }

}

class SearchHighlightNormalTextResultModel {
  final List<String> textParts;
  final List<int> matchedSearchIndexesInTextParts;

  SearchHighlightNormalTextResultModel({
    required this.textParts,
    required this.matchedSearchIndexesInTextParts,
  });
}
