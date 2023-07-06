import 'package:dating_app/models/user_model.dart';

abstract class BaseDatabaseRepository {
  Stream<UserUI> getUser(String userId);
  Stream<List<UserUI>> getUsers(String userId, String gender);
  Future<void> createUser(UserUI user);
  Future<void> updateUser(UserUI user);
  Future<void> updateUserPicture(UserUI user, String imageName);
}
