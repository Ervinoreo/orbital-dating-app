import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String text;

  const CustomButton({
    Key? key,
    this.text = 'START',
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            gradient: LinearGradient(
                colors: [Colors.orange[900]!, Colors.orange[300]!])),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0, backgroundColor: Colors.transparent),
            onPressed: () {
              if (tabController.index == 4) {
                Navigator.pushNamed(context, '/');
              } else {
                tabController.animateTo(tabController.index + 1);
              }
            },
            child: Container(
                width: double.infinity,
                child: Center(
                    child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )))));
  }
}
