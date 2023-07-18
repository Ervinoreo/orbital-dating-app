import 'package:dating_app/models/match_model.dart';
import 'package:dating_app/models/message_model.dart';
import 'package:dating_app/repositories/database/database_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/chat/chat_bloc.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';

  const ChatScreen({
    Key? key,
    required this.match,
  }) : super(key: key);

  static Route route({required Match match}) {
    print('route');
    print(match.chat);
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BlocProvider<ChatBloc>(
        create: (context) => ChatBloc(
          databaseRepository: context.read<DatabaseRepository>(),
        )..add(LoadChat(match.chat.id)),
        child: ChatScreen(match: match),
      ),
    );
  }

  final Match match;

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
                    match.matchUser.imageUrls[0],
                  ),
                ),
                Text(match.matchUser.name),
              ],
            )),
        body: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ChatLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                        child: match.chat != null
                            ? Container(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.chat.messages.length,
                                    itemBuilder: (context, index) {
                                      List<Message> messages =
                                          state.chat.messages;
                                      return ListTile(
                                          title: _Message(
                                              message: messages[index].message,
                                              isFromCurrentUser:
                                                  messages[index].senderId ==
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid));
                                    }))
                            : SizedBox()),
                  ),
                  Spacer(),
                  _MessageInput(match: match)
                ],
              );
            } else {
              return Text('Something went wrong');
            }
          },
        ));
  }
}

class _MessageInput extends StatelessWidget {
  const _MessageInput({
    Key? key,
    required this.match,
  }) : super(key: key);

  final Match match;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(20),
      height: 100,
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                print(match);
                context.read<ChatBloc>()
                  ..add(
                    AddMessage(
                      userId: match.userId,
                      matchUserId: match.matchUser.id!,
                      message: controller.text,
                    ),
                  );
                controller.clear();
              },
              icon: Icon(Icons.send_outlined)),
          Expanded(
            child: TextField(
              controller: controller,
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
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({
    super.key,
    required this.message,
    required this.isFromCurrentUser,
  });

  final String message;
  final bool isFromCurrentUser;

  @override
  Widget build(BuildContext context) {
    AlignmentGeometry alignment =
        isFromCurrentUser ? Alignment.topRight : Alignment.topLeft;

    return Align(
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.grey[200]),
        child: Text(message),
      ),
    );
  }
}
