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

  // @override
  // Future<String> createUser(UserUI user) async {
  //   String documentId = await _firebaseFirestore
  //       .collection('users')
  //       .add(user.toMap())
  //       .then((value) {
  //     print('User added, ID: ${value.id}');
  //     return value.id;
  //   });
  //   return documentId;
  // }

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

  @override
  Stream<List<UserUI>> getUsers(String userId, String gender) {
    return _firebaseFirestore
        .collection('users')
        .where('gender', isNotEqualTo: gender)
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => UserUI.fromSnapshot(doc)).toList();
    });
  }
}
