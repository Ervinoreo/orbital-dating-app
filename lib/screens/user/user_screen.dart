import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../widgets/widgets.dart';

class UserScreen extends StatelessWidget {
  static const String routeName = '/user';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => UserScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserUI user = UserUI.users[0];
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
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: NetworkImage(UserUI.users[0].imageUrls[0]),
                          fit: BoxFit.cover,
                        )),
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
              children: [
                Text(
                  '${user.name}, ${user.age}',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
