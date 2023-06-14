import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final TabController tabController;
  final String text;

  const CustomCheckBox({
    Key? key,
    required this.tabController,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (bool? newValue) {}),
        Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        )
      ],
    );
  }
}
