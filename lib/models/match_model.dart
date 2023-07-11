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
}
