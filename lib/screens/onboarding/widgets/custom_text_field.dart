import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TabController tabController;
  final String text;
  final Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.tabController,
    required this.text,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: text,
        contentPadding: EdgeInsets.only(bottom: 5.0, top: 12.5),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
      onChanged: onChanged,
    );
  }
}
