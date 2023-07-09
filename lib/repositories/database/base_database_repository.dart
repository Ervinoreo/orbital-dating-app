import 'package:dating_app/models/user_model.dart';

abstract class BaseDatabaseRepository {
  Stream<UserUI> getUser(String userId);
  Stream<List<UserUI>> getUsers(UserUI user);
  Future<void> createUser(UserUI user);
  Future<void> updateUser(UserUI user);
  Future<void> updateUserPicture(UserUI user, String imageName);
  Future<void> updateUserSwipe(
      String userId, String matchId, bool isSwipeRight);
  Future<void> updateUserMatch(String userId, String matchId);
}
