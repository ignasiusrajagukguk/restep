import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/common/constants/extentions.dart';
import 'package:restep/common/constants/text_style.dart'
    as text_style_constants;

import '../../config/app_color.dart';

class OldButtonWidget extends StatelessWidget {
  const OldButtonWidget(
      {super.key,
      required this.onTap,
      required this.child,
      this.width,
      this.height,
      this.color,
      this.borderRadius,
      this.borderColor,
      this.shadowColor});

  final VoidCallback onTap;
  final Widget child;
  final double? width;
  final double? height;
  final Color? color;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final List<Color>? shadowColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 60,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? Colors.transparent),
            color: color ?? AppColor.primary,
            gradient: color == null
                ? LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: shadowColor ?? [AppColor.silver1, AppColor.silver2])
                : null,
            borderRadius: borderRadius ?? BorderRadius.circular(10),
          ),
          child: child,
        ),
      ),
    );
  }
}

class ButtonWidget {
  static Widget basicText(
    String text, {
    double? width,
    double? height,
    action,
    double? borderRadius,
    Color? backgroundColor,
    Color? textColor,
    EdgeInsets? contentPadding = const EdgeInsets.all(10),
  }) {
    return TextButton(
      onPressed: action,
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        backgroundColor:
            WidgetStateProperty.all(backgroundColor ?? ConstColors.white),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          ),
        ),
      ),
      child: Container(
        padding: contentPadding,
        width: width,
        height: height ?? 42,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: text_style_constants.textStyleHeadingH7XxSmall
                .copyWith(color: textColor ?? Colors.black),
          ).themeHeadingH7XxSmall(),
        ),
      ),
    );
  }

  static Widget basicWidget(
    Widget content, {
    double? width,
    double? height,
    action,
    double? borderRadius,
    Color? backgroundColor,
    EdgeInsets? contentPadding = const EdgeInsets.all(10),
  }) {
    return TextButton(
      onPressed: action,
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        backgroundColor:
            WidgetStateProperty.all(backgroundColor ?? ConstColors.white),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          ),
        ),
      ),
      child: Container(
        padding: contentPadding,
        width: width,
        height: height ?? 42,
        child: content,
      ),
    );
  }
}
