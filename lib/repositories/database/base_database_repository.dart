import 'package:dating_app/models/user_model.dart';
import 'package:flutter/material.dart';

abstract class BaseDatabaseRepository {
  Stream<UserUI> getUser(String userId);
  //Future<String> createUser(UserUI user);
  Future<void> createUser(UserUI user);
  Future<void> updateUser(UserUI user);
  Future<void> updateUserPicture(UserUI user, String imageName);
}
