import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/models/models.dart';
import 'package:dating_app/repositories/storage/storage_repository.dart';
import 'package:rxdart/rxdart.dart';

import 'base_database_repository.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<UserUI> getUser(String userId) {
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snap) => UserUI.fromSnapshot(snap));
  }

  @override
  Future<void> updateUserPicture(UserUI user, String imageName) async {
    String downloadUrl =
        await StorageRepository().getDownlaodUrl(user, imageName);
    return _firebaseFirestore.collection('users').doc(user.id).update({
      'imageUrls': FieldValue.arrayUnion([downloadUrl])
    });
  }

  @override
  Future<void> createUser(UserUI user) async {
    await _firebaseFirestore.collection('users').doc(user.id).set(user.toMap());
  }

  @override
  Future<void> updateUser(UserUI user) {
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toMap())
        .then((value) => print('user document updated'));
  }

  // @override
  // Stream<List<UserUI>> getUsers(UserUI user) {
  //   List<String> userFilter = List.from(user.swipeLeft!)
  //     ..addAll(user.swipeRight!)
  //     ..add(user.id!);
  //   print('$userFilter');
  //   return _firebaseFirestore
  //       .collection('users')
  //       .where('gender', isEqualTo: 'Male')
  //       //.where(FieldPath.documentId, whereNotIn: userFilter)
  //       .snapshots()
  //       .map((snap) {
  //     return snap.docs.map((doc) => UserUI.fromSnapshot(doc)).toList();
  //   });
  // }

  @override
  Stream<List<UserUI>> getUsers(UserUI user) {
    // List<String> userFilter = List.from(user.swipeLeft!)
    //   ..addAll(user.swipeRight!)
    //   ..add(user.id!);
    return _firebaseFirestore
        .collection('users')
        .where('gender', whereIn: _selectGender(user))
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => UserUI.fromSnapshot(doc)).toList();
    });
  }

  @override
  Stream<List<UserUI>> getUsersToSwipe(UserUI user) {
    return Rx.combineLatest2(
      getUser(user.id!),
      getUsers(user),
      (
        UserUI currentUser,
        List<UserUI> users,
      ) {
        return users.where(
          (user) {
            bool isCurrentUser = user.id == currentUser.id;
            bool wasSwipedLeft = currentUser.swipeLeft!.contains(user.id);
            bool wasSwipedRight = currentUser.swipeRight!.contains(user.id);
            bool isMatch = currentUser.matches!.contains(user.id);

            bool isWithinAgeRange =
                user.age >= currentUser.ageRangePreference![0] &&
                    user.age <= currentUser.ageRangePreference![1];

            // bool isWithinDistance = _getDistance(currentUser, user) <=
            //     currentUser.distancePreference;

            if (isCurrentUser) return false;
            if (wasSwipedLeft) return false;
            if (wasSwipedRight) return false;
            if (isMatch) return false;
            if (!isWithinAgeRange) return false;
            //if (!isWithinDistance) return false;

            return true;
          },
        ).toList();
      },
    );
  }

  _selectGender(UserUI user) {
    if (user.genderPreference == null || user.genderPreference!.isEmpty) {
      return ['Male', 'Female'];
    }
    return user.genderPreference;
  }

  @override
  Future<void> updateUserSwipe(
      String userId, String matchId, bool isSwipeRight) async {
    if (isSwipeRight) {
      await _firebaseFirestore.collection('users').doc(userId).update({
        'swipeRight': FieldValue.arrayUnion([matchId])
      });
    } else {
      await _firebaseFirestore.collection('users').doc(userId).update({
        'swipeLeft': FieldValue.arrayUnion([matchId])
      });
    }
  }

  @override
  Future<void> updateUserMatch(
    String userId,
    String matchId,
  ) async {
    String chatId = await _firebaseFirestore.collection('chats').add({
      'userIds': [userId, matchId],
      'messages': [],
    }).then((value) => value.id);

    await _firebaseFirestore.collection('users').doc(userId).update({
      'matches': FieldValue.arrayUnion([
        {
          'matchId': matchId,
          'chatId': chatId,
        }
      ])
    });

    await _firebaseFirestore.collection('users').doc(matchId).update({
      'matches': FieldValue.arrayUnion([
        {
          'matchId': userId,
          'chatId': chatId,
        }
      ])
    });
  }

  @override
  Stream<List<Match>> getMatches(UserUI user) {
    return Rx.combineLatest3(
      getUser(user.id!),
      getChats(user.id!),
      getUsers(user),
      (
        UserUI user,
        List<Chat> userChats,
        List<UserUI> otherUsers,
      ) {
        return otherUsers.where(
          (otherUser) {
            List<String> matches = user.matches!
                .map((match) => match['matchId'] as String)
                .toList();
            return matches.contains(otherUser.id);
          },
        ).map(
          (matchUser) {
            Chat chat = userChats.where(
              (chat) {
                return chat.userIds.contains(matchUser.id) &
                    chat.userIds.contains(user.id);
              },
            ).first;

            return Match(
              userId: user.id!,
              matchUser: matchUser,
              chat: chat,
            );
          },
        ).toList();
      },
    );
  }
  // //List<String> userFilter = List.from(user.matches!)..add('0');
  // return _firebaseFirestore
  //     .collection('users')
  //     //.where(FieldPath.documentId, whereIn: userFilter)
  //     .snapshots()
  //     .map((snap) {
  //   return snap.docs
  //       //.where((doc) => userFilter.contains(doc.id))
  //       .map((doc) => Match.fromSnapshot(doc, user.id!))
  //       .toList();
  // });

  // _getDistance(UserUI currentUser, UserUI user) {
  //   GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
  //   var distanceInKm = geolocator.distanceBetween(
  //         currentUser.location!.lat.toDouble(),
  //         currentUser.location!.lon.toDouble(),
  //         user.location!.lat.toDouble(),
  //         user.location!.lon.toDouble(),
  //       ) ~/
  //       1000;
  //   print(
  //       'Distance in KM between ${currentUser.name} & ${user.name}: $distanceInKm');
  //   return distanceInKm;
  // }

  @override
  Stream<Chat> getChat(String chatId) {
    return _firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .snapshots()
        .map((doc) {
      return Chat.fromJson(
        doc.data() as Map<String, dynamic>,
        id: doc.id,
      );
    });
  }

  @override
  Stream<List<Chat>> getChats(String userId) {
    return _firebaseFirestore
        .collection('chats')
        .where('userIds', arrayContains: userId)
        .snapshots()
        .map((snap) {
      return snap.docs
          .map((doc) => Chat.fromJson(doc.data(), id: doc.id))
          .toList();
    });
  }

  @override
  Future<void> addMessage(String chatId, Message message) {
    return _firebaseFirestore.collection('chats').doc(chatId).update({
      'messages': FieldValue.arrayUnion(
        [
          Message(
            senderId: message.senderId,
            receiverId: message.receiverId,
            message: message.message,
            dateTime: message.dateTime,
            timeString: message.timeString,
          ).toJson()
        ],
      )
    });
  }
}
