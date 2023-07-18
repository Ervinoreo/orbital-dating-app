import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'user_model.dart';

import 'models.dart';

class Match extends Equatable {
  final String userId;
  final UserUI matchUser;
  final Chat chat;

  const Match({
    required this.userId,
    required this.matchUser,
    required this.chat,
  });

  Match copyWith({
    String? userId,
    UserUI? matchUser,
    Chat? chat,
  }) {
    return Match(
      userId: userId ?? this.userId,
      matchUser: matchUser ?? this.matchUser,
      chat: chat ?? this.chat,
    );
  }

  @override
  List<Object?> get props => [userId, matchUser, chat];
}
