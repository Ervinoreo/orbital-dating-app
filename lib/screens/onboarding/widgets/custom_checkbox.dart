import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final TabController tabController;
  final String text;
  final bool value;
  final Function(bool?)? onChanged;

  const CustomCheckBox({
    Key? key,
    required this.tabController,
    required this.text,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        )
      ],
    );
  }
}
