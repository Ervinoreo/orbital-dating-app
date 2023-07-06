import 'package:flutter/material.dart';

class CustomTextContainer extends StatelessWidget {
  final TabController? tabController;
  final String text;

  const CustomTextContainer({
    Key? key,
    this.tabController,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, right: 5),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
                colors: [Colors.orange[900]!, Colors.orange[300]!])),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
