import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => ProfileScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserUI user = UserUI.users[0];
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.orange[900],
            title: Text('Profile'),
            actions: [
              IconButton(icon: Icon(Icons.message), onPressed: () {}),
              IconButton(icon: Icon(Icons.person), onPressed: () {}),
            ]),
        body: Column(
          children: [
            SizedBox(height: 5),
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3, 3),
                        blurRadius: 3,
                        spreadRadius: 3,
                      )
                    ],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(user.imageUrls[0]),
                    ),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange[900]!.withOpacity(0.05),
                          Colors.orange[900]!.withOpacity(0.2),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(user.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          )),
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TitleWithIcon(title: 'Biography', icon: Icons.edit),
                  Text(
                    user.bio,
                  ),
                  TitleWithIcon(title: 'Pictures', icon: Icons.edit),
                  TitleWithIcon(title: 'Interest', icon: Icons.edit),
                ],
              ),
            ),
          ],
        ));
  }
}

class TitleWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;

  const TitleWithIcon({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title),
      IconButton(
        icon: Icon(icon),
        onPressed: () {},
      ),
    ]);
  }
}
