import 'package:image_picker/image_picker.dart';

import '../../models/models.dart';

abstract class BaseStorageRepository {
  Future<void> uploadImage(UserUI user, XFile image);
  Future<String> getDownlaodUrl(UserUI user, String imageName);
}
