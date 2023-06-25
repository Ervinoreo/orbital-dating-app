import 'dart:io';

import 'package:dating_app/repositories/database/database_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../models/models.dart';
import 'base_storage_repository.dart';

class StorageRepository extends BaseStorageRepository {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  Future<void> uploadImage(UserUI user, XFile image) async {
    try {
      print(image.path);
      await storage
          .ref('${user.id}/${image.name}')
          .putFile(File(image.path))
          .then(
              (p0) => DatabaseRepository().updateUserPicture(user, image.name));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<String> getDownlaodUrl(UserUI user, String imageName) async {
    String downloadUrl =
        await storage.ref('${user.id}/$imageName').getDownloadURL();
    return downloadUrl;
  }
}
