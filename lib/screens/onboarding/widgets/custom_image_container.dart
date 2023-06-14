import 'package:flutter/material.dart';

class CustomImageContainer extends StatelessWidget {
  final TabController tabController;

  const CustomImageContainer({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 10),
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border(
              bottom: BorderSide(color: Colors.orange[900]!, width: 1),
              top: BorderSide(color: Colors.orange[900]!, width: 1),
              left: BorderSide(color: Colors.orange[900]!, width: 1),
              right: BorderSide(color: Colors.orange[900]!, width: 1),
            )),
        child: Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
