import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.beginColor,
    required this.endColor,
    required this.textColor,
    this.onPressed,
    this.width = 200,
  }) : super(key: key);

  final String text;
  final Color beginColor;
  final Color endColor;
  final Color textColor;
  final double width;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(2, 2),
          ),
        ],
        gradient: LinearGradient(
          colors: [
            beginColor,
            endColor,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          fixedSize: Size(width, 40),
        ),
        child: Container(
          width: double.infinity,
          child: Center(
            child: Text(text,
                style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
