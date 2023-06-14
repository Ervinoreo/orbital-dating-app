import 'package:dating_app/models/user_match_model.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';

  static Route route({required UserMatch userMatch}) {
    return MaterialPageRoute(
      builder: (_) => ChatScreen(userMatch: userMatch),
      settings: RouteSettings(name: routeName),
    );
  }

  final UserMatch userMatch;

  const ChatScreen({required this.userMatch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.orange[900],
            title: Column(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                    userMatch.matchedUser.imageUrls[0],
                  ),
                ),
                Text(userMatch.matchedUser.name),
              ],
            )),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: userMatch.chat != null
                      ? Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: userMatch.chat![0].messages.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    title: userMatch.chat![0].messages[index]
                                                .senderId ==
                                            1
                                        ? Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8.0)),
                                                  color: Colors.grey[200]),
                                              child: Text(userMatch.chat![0]
                                                  .messages[index].message),
                                            ),
                                          )
                                        : Align(
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 15,
                                                  backgroundImage: NetworkImage(
                                                    userMatch.matchedUser
                                                        .imageUrls[0],
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8.0)),
                                                      color: Colors.grey[200]),
                                                  child: Text(userMatch.chat![0]
                                                      .messages[index].message),
                                                ),
                                              ],
                                            ),
                                          ));
                              }))
                      : SizedBox()),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              height: 100,
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.send_outlined)),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Type here...',
                        contentPadding:
                            const EdgeInsets.only(left: 20, bottom: 5, top: 5),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
