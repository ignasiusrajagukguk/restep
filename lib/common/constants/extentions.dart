import 'package:flutter/material.dart';

import 'text_style.dart';

extension WidgetMediaQuery on BuildContext {
  double widthFull() {
    return MediaQuery.of(this).size.width;
  }

  double heightFull() {
    return MediaQuery.of(this).size.height;
  }
}

extension TextExt on Text {
  Text themeHeadingH1XxLarge() => attrCopy(textStyleHeadingH1XxLarge);
  Text themeHeadingH2XLarge() => attrCopy(textStyleHeadingH2XLarge);
  Text themeHeadingH3Large() => attrCopy(textStyleHeadingH3Large);
  Text themeHeadingH4Default() => attrCopy(textStyleHeadingH4Default);
  Text themeHeadingH4Bold() => attrCopy(textStyleHeadingH4Bold);
  Text themeHeadingH5Small() => attrCopy(textStyleHeadingH5Small);
  Text themeHeadingH6XSmall() => attrCopy(textStyleHeadingH6XSmall);
  Text themeHeadingCapsXSmall() => attrCopy(textStyleHeadingCapsXSmall);
  Text themeHeadingCapsSmall() => attrCopy(textStyleHeadingCapsSmall);
  Text themeHeadingCapsDefault() => attrCopy(textStyleHeadingCapsDefault);
  Text themeHeadingH7XxSmall() => attrCopy(textStyleHeadingH7XxSmall);
  Text themeHeadingH8SuperSmall() => attrCopy(textStyleHeadingH8SuperSmall);
  Text themeTextXlarge() => attrCopy(textStyleTextXlarge);
  Text themeTextLarge() => attrCopy(textStyleTextLarge);
  Text themeTextDefault() => attrCopy(textStyleTextDefault);
  Text themeTextSmall() => attrCopy(textStyleTextSmall);
  Text themeTextXSmall() => attrCopy(textStyleTextXSmall);
  Text themeParagraphXlarge() => attrCopy(textStyleParagraphXlarge);
  Text themeParagraphLarge() => attrCopy(textStyleParagraphLarge);
  Text themeParagraphDefault() => attrCopy(textStyleParagraphDefault);
  Text themeParagraphSmall() => attrCopy(textStyleParagraphSmall);

  Text attrCopy(TextStyle style) {
    if (this.style != null) {
      style = this
          .style!
          .copyWith(fontFamily: style.fontFamily, fontSize: style.fontSize);
    }
    return Text(data!, style: style, textAlign: textAlign);
  }
}
