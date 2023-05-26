import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/models/user_model.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => HomeScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange[900],
          title: Text('WassupNus'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                icon: Icon(Icons.logout)),
            IconButton(icon: Icon(Icons.message), onPressed: () {}),
            IconButton(icon: Icon(Icons.person), onPressed: () {}),
          ]),
      body: Column(
        children: [
          UserCard(user: UserUI.users[0]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChoiceButton(
                  width: 60,
                  height: 60,
                  size: 25,
                  color: Color.fromRGBO(235, 106, 19, 1),
                  icon: Icons.clear_rounded,
                ),
                ChoiceButton(
                  width: 60,
                  height: 60,
                  size: 25,
                  color: Color.fromRGBO(235, 106, 19, 1),
                  icon: Icons.favorite,
                ),
                ChoiceButton(
                  width: 60,
                  height: 60,
                  size: 25,
                  color: Color.fromRGBO(235, 106, 19, 1),
                  icon: Icons.watch_later,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChoiceButton extends StatelessWidget {
  final double width;
  final double height;
  final double size;
  final Color color;
  final IconData icon;

  const ChoiceButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.size,
      required this.color,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: color,
              spreadRadius: 4,
              blurRadius: 4,
              offset: Offset(3, 3),
            ),
          ]),
      child: Icon(icon, color: color),
    );
  }
}

class UserCard extends StatelessWidget {
  final UserUI user;

  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.4,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(user.imageUrls[0]),
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 4,
                      offset: Offset(3, 3),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 30,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${user.name}, ${user.age}',
                        style: TextStyle(
                          color: Colors.orange[900],
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        )),
                    Text('${user.jobTitle}',
                        style: TextStyle(
                          color: Colors.orange[900],
                          fontSize: 20,
                        )),
                    Row(
                      children: [
                        UserImageSmall(imageUrl: user.imageUrls[1]),
                        UserImageSmall(imageUrl: user.imageUrls[2]),
                        UserImageSmall(imageUrl: user.imageUrls[3]),
                        UserImageSmall(imageUrl: user.imageUrls[4]),
                        SizedBox(width: 10),
                        Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.info_outline,
                              size: 25,
                              color: Colors.orange[900],
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class UserImageSmall extends StatelessWidget {
  const UserImageSmall({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, right: 8),
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            imageUrl,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
