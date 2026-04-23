import 'package:flutter/material.dart';

class UnorderedListTextWidget extends StatelessWidget {
  const UnorderedListTextWidget(
    this.text, {
    super.key,
    this.style,
  });
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "• ",
          style: style ?? TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        Expanded(
          child: Text(
            text,
            style:
                style ?? TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ),
      ],
    );
  }
}
