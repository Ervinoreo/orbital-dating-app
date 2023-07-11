import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'user_model.dart';

import 'models.dart';

class Match extends Equatable {
  final String userId;
  final UserUI matchedUser;
  final List<Chat>? chat;

  const Match({
    required this.userId,
    required this.matchedUser,
    this.chat,
  });

  static Match fromSnapshot(DocumentSnapshot snap, String userId) {
    Match match = Match(userId: userId, matchedUser: UserUI.fromSnapshot(snap));
    return match;
  }

  @override
  List<Object?> get props => [userId, matchedUser, chat];

  static List<Match> matches = [
    Match(
      userId: '1',
      matchedUser: UserUI.users[1],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.matchedUserId == 2)
          .toList(),
    ),
    Match(
      userId: '1',
      matchedUser: UserUI.users[2],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.matchedUserId == 3)
          .toList(),
    ),
    Match(
      userId: '1',
      matchedUser: UserUI.users[3],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.matchedUserId == 4)
          .toList(),
    ),
    Match(
      userId: '1',
      matchedUser: UserUI.users[4],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.matchedUserId == 5)
          .toList(),
    ),
    Match(
      userId: '1',
      matchedUser: UserUI.users[5],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.matchedUserId == 6)
          .toList(),
    ),
    Match(
      userId: '1',
      matchedUser: UserUI.users[6],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.matchedUserId == 7)
          .toList(),
    ),
    Match(
      userId: '1',
      matchedUser: UserUI.users[7],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.matchedUserId == 8)
          .toList(),
    ),
    Match(
      userId: '1',
      matchedUser: UserUI.users[8],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.matchedUserId == 9)
          .toList(),
    ),
  ];
}
