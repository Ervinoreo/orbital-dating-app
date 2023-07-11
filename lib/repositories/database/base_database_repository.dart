import 'package:dating_app/models/models.dart';

abstract class BaseDatabaseRepository {
  Stream<UserUI> getUser(String userId);
  Stream<List<UserUI>> getUsersToSwipe(UserUI user);
  Stream<List<UserUI>> getUsers(UserUI user);
  Stream<List<Match>> getMatches(UserUI user);
  Future<void> createUser(UserUI user);
  Future<void> updateUser(UserUI user);
  Future<void> updateUserPicture(UserUI user, String imageName);
  Future<void> updateUserSwipe(
      String userId, String matchId, bool isSwipeRight);
  Future<void> updateUserMatch(String userId, String matchId);
}
