import 'package:dating_app/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../models/user_match_model.dart';

class MatchesScreen extends StatelessWidget {
  static const String routeName = '/matches';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => MatchesScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inactiveMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isEmpty)
        .toList();
    final activeMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isNotEmpty)
        .toList();

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.orange[900],
            title: Text('Matches'),
            actions: [
              IconButton(icon: Icon(Icons.message), onPressed: () {}),
              IconButton(icon: Icon(Icons.person), onPressed: () {}),
            ]),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Likes',
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: inactiveMatches.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          UserImageSmall(
                              height: 70,
                              width: 70,
                              url: inactiveMatches[index]
                                  .matchedUser
                                  .imageUrls[0]),
                          Text(inactiveMatches[index].matchedUser.name)
                        ],
                      );
                    }),
              ),
              SizedBox(height: 10),
              Text(
                'Your Chats',
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: activeMatches.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/chat',
                            arguments: activeMatches[index]);
                      },
                      child: Row(
                        children: [
                          UserImageSmall(
                            height: 70,
                            width: 70,
                            url: activeMatches[index].matchedUser.imageUrls[0],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activeMatches[index].matchedUser.name,
                              ),
                              SizedBox(height: 5),
                              Text(
                                activeMatches[index]
                                    .chat![0]
                                    .messages[0]
                                    .message,
                              ),
                              SizedBox(height: 5),
                              Text(
                                activeMatches[index]
                                    .chat![0]
                                    .messages[0]
                                    .timeString,
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        )));
  }
}
