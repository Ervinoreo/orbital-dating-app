import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/repositories/storage/storage_repository.dart';

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
    List<String> userFilter = List.from(user.swipeLeft!)
      ..addAll(user.swipeRight!)
      ..add(user.id!);
    return _firebaseFirestore
        .collection('users')
        .where('gender', isEqualTo: 'Male')
        .snapshots()
        .map((snap) {
      return snap.docs
          .where((doc) => !userFilter.contains(doc.id))
          .map((doc) => UserUI.fromSnapshot(doc))
          .toList();
    });
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
}
