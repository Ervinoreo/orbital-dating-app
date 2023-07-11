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
        .where('gender', isEqualTo: _selectGender(user))
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => UserUI.fromSnapshot(doc)).toList();
    });
  }

  @override
  Stream<List<UserUI>> getUsersToSwipe(UserUI user) {
    return Rx.combineLatest2(getUser(user.id!), getUsers(user),
        (UserUI currentUser, List<UserUI> users) {
      return users.where((user) {
        if (currentUser.swipeLeft!.contains(user.id)) {
          return false;
        } else if (currentUser.swipeRight!.contains(user.id)) {
          return false;
        } else if (currentUser.matches!.contains(user.id)) {
          return false;
        } else {
          return true;
        }
      }).toList();
    });
  }

  _selectGender(UserUI user) {
    return (user.gender == 'Female') ? 'Male' : 'Female';
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
  Future<void> updateUserMatch(String userId, String matchId) async {
    await _firebaseFirestore.collection('users').doc(userId).update({
      'matches': FieldValue.arrayUnion([matchId])
    });

    await _firebaseFirestore.collection('users').doc(matchId).update({
      'matches': FieldValue.arrayUnion([userId])
    });
  }

  @override
  Stream<List<Match>> getMatches(UserUI user) {
    return Rx.combineLatest2(getUser(user.id!), getUsers(user),
        (UserUI currentUser, List<UserUI> users) {
      return users
          .where((user) => currentUser.matches!.contains(user.id))
          .map((user) => Match(userId: user.id!, matchedUser: user))
          .toList();
    });
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
  }
}
