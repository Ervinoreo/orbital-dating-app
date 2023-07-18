import 'package:dating_app/bloc/match/match_bloc.dart';
import 'package:dating_app/repositories/database/database_repository.dart';
import 'package:dating_app/screens/chat/chat_screen.dart';
import 'package:dating_app/screens/onboarding/widgets/custom_elevated_button.dart';
import 'package:dating_app/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/match_model.dart';

class MatchesScreen extends StatelessWidget {
  static const String routeName = '/matches';

  static Route route() {
    return MaterialPageRoute(
      // builder: (context) => BlocProvider<MatchBloc>(
      //   create: (context) => MatchBloc(
      //     databaseRepository: context.read<DatabaseRepository>(),
      //   ),
      //   child: MatchesScreen(),
      // ),
      builder: (context) => MatchesScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.orange[900],
            title: Text('Matches'),
            actions: [
              IconButton(
                  icon: Icon(Icons.message),
                  onPressed: () {
                    Navigator.pushNamed(context, '/matches');
                  }),
              IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  }),
            ]),
        body: BlocBuilder<MatchBloc, MatchState>(
          builder: (context, state) {
            if (state is MatchLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is MatchLoaded) {
              final inactiveMatches = state.matches
                  .where((match) => match.chat.messages.length == 0)
                  .toList();
              final activeMatches = state.matches
                  .where((match) => match.chat.messages.length > 0)
                  .toList();
              return SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Likes',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    inactiveMatches.length == 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text('Go back to swiping'),
                          )
                        : MatchesList(inactiveMatches: inactiveMatches),
                    SizedBox(height: 10),
                    Text(
                      'Your Chats',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ChatList(activeMatches: activeMatches)
                  ],
                ),
              ));
            }
            if (state is MatchUnavailable) {
              return Column(
                children: [
                  Text(
                    'No matches yet.',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomElevatedButton(
                    text: 'Back To Swiping',
                    beginColor: Colors.black,
                    endColor: Colors.black,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            } else {
              return Center(
                child: Text('Something went wrong.'),
              );
            }
          },
        ));
  }
}

class ChatList extends StatelessWidget {
  const ChatList({
    super.key,
    required this.activeMatches,
  });

  final List<Match> activeMatches;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: activeMatches.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                ChatScreen.routeName,
                arguments: activeMatches[index],
              );
            },
            child: Row(
              children: [
                UserImageSmall(
                  height: 70,
                  width: 70,
                  url: activeMatches[index].matchUser.imageUrls[0],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activeMatches[index].matchUser.name,
                    ),
                    SizedBox(height: 5),
                    Text(
                      activeMatches[index].chat.messages[0].message,
                    ),
                    SizedBox(height: 5),
                    Text(
                      activeMatches[index].chat.messages[0].timeString,
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}

class MatchesList extends StatelessWidget {
  const MatchesList({
    Key? key,
    required this.inactiveMatches,
  }) : super(key: key);

  final List<Match> inactiveMatches;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: inactiveMatches.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                ChatScreen.routeName,
                arguments: inactiveMatches[index],
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10.0),
              child: Column(
                children: [
                  UserImageSmall(
                    height: 70,
                    width: 70,
                    url: inactiveMatches[index].matchUser.imageUrls[0],
                  ),
                  Text(
                    inactiveMatches[index].matchUser.name,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
