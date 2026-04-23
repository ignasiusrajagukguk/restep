import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restep/config/app_color.dart';

const _errorStyleNoLabel = TextStyle(
  color: Colors.red,
  height: 0,
);

class TextFormFieldWidget {
  static Widget height42(String hint,
      {TextEditingController? controller,
      FormFieldValidator<String>? validator,
      AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
      String? initialValue,
      FocusNode? focusNode,
      VoidCallback? onEditingComplete,
      bool enable = true,
      TextInputType keyboardType = TextInputType.text,
      int? maxLines = 1,
      int? maxLength,
      EdgeInsets? contentPadding = const EdgeInsets.fromLTRB(10, 0, 10, 0),
      List<TextInputFormatter>? inputFormatters,
      TextStyle textStyle =
           const TextStyle(fontSize: 14),
      bool? isObscureText,
      OutlineInputBorder? focusBorderColor,
      TextAlign? textAlign,
      Color? fillColor,
      Widget? suffixIcon,
      Widget? prefixIcon,
      Function(String? value)? onChanged,
      Color? textColor,
      OutlineInputBorder? border,
      OutlineInputBorder? enabledBorder,
      OutlineInputBorder? disabledBorder,
      bool? readOnly,
      double? borderRadius}) {
    return SizedBox(
      // constraints: const BoxConstraints(minHeight: 40),
      height: 42,
      child: TextFormField(
        textAlign: textAlign ?? TextAlign.start,
        readOnly:readOnly ?? false,
        autovalidateMode: autovalidateMode,
        obscureText: isObscureText ?? false,
        controller: controller,
        initialValue: initialValue,
        enableSuggestions: true,
        validator: validator,
        onEditingComplete: onEditingComplete,
        focusNode: focusNode,
        enabled: enable,
        style: textStyle.copyWith(color: textColor??Colors.black),
        maxLines: maxLines,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: _Border._defaultInputDecoration(
            style: textStyle,
            border: border,
            contentPadding: contentPadding,
            focusedBorder: focusBorderColor,
            disabledBorder: disabledBorder,
            filled: true,
            fillColor: fillColor,enabledBorder: enabledBorder,
            hint: hint,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            borderRadius: borderRadius),
        onChanged: onChanged,
      ),
    );
  }
}

class _Border {
  //default border
  static OutlineInputBorder _defaultBorder({double? borderRadius}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      borderSide:  const BorderSide(
        color: Colors.blue,
        width: .5,
      ),
    );
  }

  static OutlineInputBorder _focusedBorder({double? borderRadius}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
      borderSide:  BorderSide(
        width: 1,
      ),
    );
  }

  static OutlineInputBorder _enabledBorder({double? borderRadius}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    );
  }

  static OutlineInputBorder _errorBorder({double? borderRadius}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      borderSide: const BorderSide(
        color: Colors.blue,
        width: 1.0,
      ),
    );
  }

  static InputDecoration _defaultInputDecoration(
      {EdgeInsetsGeometry? contentPadding,
      String? hint,
      bool filled = true,
      OutlineInputBorder? focusedBorder,
      OutlineInputBorder? border,
      OutlineInputBorder? enabledBorder,
      OutlineInputBorder? disabledBorder,
      Color? fillColor,
      required TextStyle style,
      Widget? suffixIcon,
      Widget? prefixIcon,
      double? borderRadius}) {
    return InputDecoration(
      contentPadding: contentPadding,
      border: border??_Border._defaultBorder(borderRadius: borderRadius),
      focusedBorder: focusedBorder ??
          _Border._focusedBorder(borderRadius: borderRadius),
      enabledBorder: enabledBorder?? _Border._enabledBorder(borderRadius: borderRadius),
      errorBorder: _Border._errorBorder(borderRadius: borderRadius),
      errorStyle: _errorStyleNoLabel,
      disabledBorder: disabledBorder,
      filled: filled,
      prefixIcon: prefixIcon,
      fillColor: fillColor ?? Colors.white,
      hintText: hint,
      hintStyle: TextStyle(color: AppColor.light.withValues(alpha: .5)),
      counterText: '',
      suffixIcon: suffixIcon,
    );
  }
}