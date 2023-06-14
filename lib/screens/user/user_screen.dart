import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../widgets/widgets.dart';

class UserScreen extends StatelessWidget {
  static const String routeName = '/user';

  static Route route({required UserUI user}) {
    return MaterialPageRoute(
      builder: (_) => UserScreen(user: user),
      settings: RouteSettings(name: routeName),
    );
  }

  final UserUI user;

  const UserScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Hero(
                    tag: 'user-image',
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            image: NetworkImage(user.imageUrls[0]),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ChoiceButton(
                          width: 60,
                          height: 60,
                          size: 25,
                          color: Color.fromRGBO(235, 106, 19, 1),
                          icon: Icons.clear_rounded,
                        ),
                        ChoiceButton(
                          width: 80,
                          height: 80,
                          size: 30,
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
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}, ${user.age}',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${user.jobTitle}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'About',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${user.bio}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    height: 2,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Interests',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: user.interests
                      .map(
                        (interest) => Container(
                          padding: EdgeInsets.all(5.0),
                          margin: EdgeInsets.only(top: 5.0, right: 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              gradient: LinearGradient(colors: [
                                Colors.orange[900]!,
                                Colors.orange[300]!
                              ])),
                          child: Text(
                            interest,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
