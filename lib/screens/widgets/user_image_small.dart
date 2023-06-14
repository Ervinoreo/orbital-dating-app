import 'package:flutter/material.dart';

class UserImageSmall extends StatelessWidget {
  final String url;
  final double height;
  final double width;

  const UserImageSmall({
    Key? key,
    required this.url,
    this.height = 60,
    this.width = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, right: 8),
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            url,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
