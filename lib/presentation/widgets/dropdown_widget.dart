import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final String value;
  final String title;
  final List<dynamic> items;
  final void Function(dynamic)? onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? onEditingComplete;
  final bool? enabled;
  final TextStyle? style;
  final Widget? suffixIcon;
  final OutlineInputBorder? border;
  final String? hint;
  final TextStyle? hintStyle;

  const DropdownWidget({
    super.key,
    required this.value,
    required this.title,
    required this.items,
    required this.onChanged,
    this.validator,
    this.onEditingComplete,
    this.enabled,
    this.style,
    this.suffixIcon,
    this.border,
    this.hint,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField(
            isExpanded: true,
            dropdownColor: Colors.grey.shade100,
            icon: Icon(Icons.keyboard_arrow_down_rounded),
            elevation: 16,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: hint ?? "choose",
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
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(15),
            ),
            value: value == "" || value == "null" ? null : value,
            onChanged: onChanged,
            items: items
                .map((label) => DropdownMenuItem(
                      value: label,
                      child: Text(label),
                    ))
                .toList()),
      ],
    );
  }
}
