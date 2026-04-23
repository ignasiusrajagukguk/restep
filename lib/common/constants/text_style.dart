import 'package:flutter/material.dart';
import 'package:restep/common/constants/fonts_family.dart';


// Heading
TextStyle textStyleHeadingH1XxLarge = const TextStyle(
    fontFamily: monstserratSemiBold, fontSize: 46); //H1-Xxlarge, Bold 46
TextStyle textStyleHeadingH2XLarge = const TextStyle(
    fontFamily: monstserratSemiBold, fontSize: 28); //H2-Xlarge, Bold 28
TextStyle textStyleHeadingH3Large = const TextStyle(
    fontFamily: monstserratSemiBold, fontSize: 24); //H3-Large, Semibold 24
TextStyle textStyleHeadingH4Default = const TextStyle(
    fontFamily: monstserratSemiBold, fontSize: 22); //H4-Default, sb 22
TextStyle textStyleHeadingH4Bold = const TextStyle(
    fontFamily: monstserratSemiBold, fontSize: 22); //H4-Default, sb 22
TextStyle textStyleHeadingH5Small =
    const TextStyle(fontFamily: monstserratSemiBold, fontSize: 18); //H5-Small, b 18
TextStyle textStyleHeadingH6XSmall =
    const TextStyle(fontFamily: monstserratSemiBold, fontSize: 16); //H6-Xsmall,b 16
TextStyle textStyleHeadingCapsXSmall = const TextStyle(
    fontFamily: monstserratRegular, fontSize: 12); //Caps-Xsmall, regular 12
TextStyle textStyleHeadingCapsSmall =
    const TextStyle(fontFamily: monstserratSemiBold, fontSize: 14); //Caps-Small, b 14
TextStyle textStyleHeadingCapsDefault = const TextStyle(
    fontFamily: monstserratSemiBold, fontSize: 16); //Caps-Default, sb 16
TextStyle textStyleHeadingH7XxSmall = const TextStyle(
    fontFamily: monstserratSemiBold, fontSize: 14); //H7-Xxsmall, sb 14
TextStyle textStyleHeadingH8SuperSmall = const TextStyle(
    fontFamily: monstserratSemiBold, fontSize: 12); //H8-Supersmall, sb 12

//Text
TextStyle textStyleTextXlarge = const TextStyle(
    fontFamily: monstserratRegular, fontSize: 18); //Text-Xlarge, regular 18
TextStyle textStyleTextLarge = const TextStyle(
    fontFamily: monstserratRegular, fontSize: 16); //Text-Large, regular 16
TextStyle textStyleTextDefault = const TextStyle(
    fontFamily: monstserratRegular, fontSize: 14); //Text-Default, regular 14
TextStyle textStyleTextSmall = const TextStyle(
    fontFamily: monstserratRegular, fontSize: 12); //Text-Small, regular 12
TextStyle textStyleTextXSmall = const TextStyle(
    fontFamily: monstserratRegular, fontSize: 10); //Text-XSmall, regular 10

// Paragraph
TextStyle textStyleParagraphXlarge = const TextStyle(
    fontFamily: monstserratRegular, fontSize: 18); //Paragraph-Xlarge, r 18
TextStyle textStyleParagraphLarge = const TextStyle(
    fontFamily: monstserratRegular, fontSize: 16); //Paragraph-Large, r 16
TextStyle textStyleParagraphDefault = const TextStyle(
    fontFamily: monstserratRegular, fontSize: 14); //Paragraph-Default, r 14
TextStyle textStyleParagraphSmall = const TextStyle(
    fontFamily: monstserratRegular, fontSize: 12); //Paragraph-Small, r 12

class TextStyleConstants {
// Heading
  static TextStyle textStyleHeadingH1XxLargeBold = const TextStyle(
      fontSize: 46, fontWeight: FontWeight.bold);
  static TextStyle textStyleHeadingH1XxLarge = const TextStyle(
      fontFamily: monstserratSemiBold, fontSize: 46); //H1-Xxlarge, Bold 46
  static TextStyle textStyleHeadingH2XLarge =  TextStyle(
      fontFamily: monstserratSemiBold, fontSize: 28, fontWeight: FontWeight.bold); //H2-Xlarge, Bold 28
  static TextStyle textStyleHeadingH3Large = const TextStyle(
      fontFamily: monstserratSemiBold, fontSize: 24); //H3-Large, Semibold 24
  static TextStyle textStyleHeadingH4Default = const TextStyle(
      fontFamily: monstserratSemiBold, fontSize: 22); //H4-Default, sb 22
  static TextStyle textStyleHeadingH4Bold = const TextStyle(
      fontFamily: monstserratSemiBold, fontSize: 22); //H4-Default, sb 22
  static TextStyle textStyleHeadingSize20 = const TextStyle(
      fontFamily: monstserratSemiBold, fontSize: 20); //H4-Default, sb 22
  static TextStyle textStyleHeadingH5Small = const TextStyle(
      fontFamily: monstserratSemiBold,
      fontSize: 18,
      fontWeight: FontWeight.w600); //H5-Small, b 18
  static TextStyle textStyleHeadingH5W500 = const TextStyle(
      fontFamily: monstserratSemiBold,
      fontSize: 18,
      fontWeight: FontWeight.w500); //H5-Small, b 18
  static TextStyle textStyleHeadingH6XSmall = const TextStyle(
      fontFamily: monstserratBold,
      fontSize: 16,
      fontWeight: FontWeight.w600); //H6-Xsmall,b 16
  static TextStyle textStyleHeadingCapsXSmall = const TextStyle(
      fontFamily: monstserratRegular, fontSize: 12); //Caps-Xsmall, regular 12
  static TextStyle textStyleHeadingCapsSmall = const TextStyle(
      fontFamily: monstserratSemiBold, fontSize: 14); //Caps-Small, b 14
  static TextStyle textStyleHeadingCapsDefault = const TextStyle(
      fontFamily: monstserratSemiBold,
      fontSize: 16,
      fontWeight: FontWeight.w600); //Caps-Default, sb 16
  static TextStyle textStyleHeadingW500 = const TextStyle(
      fontFamily: monstserratSemiBold,
      fontSize: 16,
      fontWeight: FontWeight.w500); //Caps-Default, sb 16
  static TextStyle textStyleHeadingH7XxSmall = const TextStyle(
      fontFamily: monstserratSemiBold, fontSize: 14); //H7-Xxsmall, sb 14
  static TextStyle textStyleHeadingH8SuperSmall = const TextStyle(
      fontFamily: monstserratSemiBold, fontSize: 12); //H8-Supersmall, sb 12

//Text
  static TextStyle textStyleTextXlarge = const TextStyle(
      fontFamily: monstserratRegular, fontSize: 18); //Text-Xlarge, regular 18
  static TextStyle textStyleTextLarge = const TextStyle(
      fontFamily: monstserratRegular, fontSize: 16); //Text-Large, regular 16
  static TextStyle textStyleTextLargeBold = const TextStyle(
      fontFamily: monstserratSemiBold, fontSize: 16); //Text-Large, regular 16
  static TextStyle textStyleTextDefault = const TextStyle(
      fontFamily: monstserratRegular, fontSize: 15); //Text-Default, regular 15
  static TextStyle textStyleTextDefaultBold = const TextStyle(
      fontFamily: monstserratSemiBold,
      fontSize: 15,
      
      fontWeight: FontWeight.w500);
  static TextStyle textStyleTextDefaultLight = const TextStyle(
      fontFamily: monstserratLight,
      fontSize: 15,
      fontWeight: FontWeight.w400); //Text-Default, regular 15

  static TextStyle textStyleTextSize13Regular = const TextStyle(
      fontFamily: monstserratRegular, fontSize: 13); //Text-Small, regular 13
  static TextStyle textStyleTextSize13Bold = const TextStyle(
      fontFamily: monstserratSemiBold,
      fontSize: 13,
      fontWeight: FontWeight.w500); //Text-Small, Bold 13
  static TextStyle textStyleTextSmall = const TextStyle(
    fontFamily: monstserratRegular,
    fontSize: 12,
  ); //Text-Small, regular 12
  static TextStyle textStyleTextSmallBold = const TextStyle(
    fontFamily: monstserratSemiBold,
    fontSize: 12,
  ); //Text-Small, regular 12
  static TextStyle textStyleTextSmallUnderline = const TextStyle(
      fontFamily: monstserratRegular,
      fontSize: 12,
      decoration: TextDecoration.underline); //Text-Small, regular 12
  static TextStyle textStyleTextXSmall = const TextStyle(
      fontFamily: monstserratRegular,
      fontSize: 10,
      fontWeight: FontWeight.w400); //Text-XSmall, regular 10
  static TextStyle textStyleTextXSmallBold = const TextStyle(
      fontFamily: monstserratBold,
      fontSize: 10,
      fontWeight: FontWeight.w500); //Text-XSmall, bold 10

// Paragraph
  static TextStyle textStyleParagraphXlarge = const TextStyle(
      fontFamily: monstserratRegular, fontSize: 18); //Paragraph-Xlarge, r 18
  static TextStyle textStyleParagraphLarge = const TextStyle(
      fontFamily: monstserratRegular, fontSize: 16); //Paragraph-Large, r 16
  static TextStyle textStyleParagraphDefault = const TextStyle(
      fontFamily: monstserratRegular, fontSize: 14); //Paragraph-Default, r 14
  static TextStyle textStyleParagraphSmall = const TextStyle(
      fontFamily: monstserratRegular, fontSize: 12); //Paragraph-Small, r 12

// TextWidget

  static TextStyle textStyleTextWidgetSize80 = const TextStyle(
      fontFamily: monstserratBold, fontSize: 80); //Paragraph-Small, r 12

}
