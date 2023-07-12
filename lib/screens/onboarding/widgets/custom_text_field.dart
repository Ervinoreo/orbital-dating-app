import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? text;
  final String? initialValue;
  final Function(String)? onChanged;
  final Function(bool)? onFocusChanged;
  final EdgeInsets padding;

  CustomTextField({
    Key? key,
    this.text = '',
    this.initialValue = '',
    this.onChanged,
    this.onFocusChanged,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Focus(
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: text,
            contentPadding: EdgeInsets.only(bottom: 5.0, top: 12.5),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
          ),
          onChanged: onChanged,
        ),
        onFocusChange: onFocusChanged ?? (hasFocus) {},
      ),
    );
  }
}
