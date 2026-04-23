import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/app_color.dart';

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget({
    super.key,
    required this.title,
    this.textAlign,
    this.autovalidateMode,
    this.obscureText,
    this.controller,
    this.initialValue,
    this.validator,
    this.onEditingComplete,
    this.focusNode,
    this.enabled,
    this.style,
    this.maxLines,
    this.inputFormatters,
    this.keyboardType,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction,
    this.onChanged,
    this.border,
    this.hint,
    this.hintStyle,
    this.withTitle = true,
    this.titleColor, this.fillColor
  });

  final String title;
  final TextAlign? textAlign;
  final AutovalidateMode? autovalidateMode;
  final bool? obscureText;
  final TextEditingController? controller;
  final String? initialValue;
  final String? Function(String?)? validator;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final bool? enabled;
  final TextStyle? style;
  final int? maxLines;
  final Color? titleColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final OutlineInputBorder? border;
  final String? hint;
  final TextStyle? hintStyle;
  final bool withTitle;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        withTitle
            ? Text(
                title,
                style:  TextStyle(fontWeight: FontWeight.bold, color: titleColor),
              )
            : SizedBox(),
        SizedBox(height: withTitle ? 8 : 0),
        TextFormField(
          textAlign: textAlign ?? TextAlign.start,
          autovalidateMode: autovalidateMode,
          obscureText: obscureText ?? false,
          controller: controller,
          initialValue: initialValue,
          enableSuggestions: true,
          validator: validator,
          onEditingComplete: onEditingComplete,
          focusNode: focusNode,
          enabled: enabled,
          style: style,
          maxLines: maxLines ?? 1,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          maxLength: maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          textInputAction: textInputAction ?? TextInputAction.next,
          cursorColor: AppColor.black,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: hintStyle ?? TextStyle(color: Colors.grey),
            border: border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
            focusedBorder: border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
            disabledBorder: border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
            enabledBorder: border ??
                OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
            filled: true,
            fillColor: fillColor?? Colors.white,
            contentPadding: const EdgeInsets.all(15),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
