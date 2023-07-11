import '../../models/location_model.dart';

abstract class BaseLocationRepository {
  Future<Location?> getLocation(String placeId);
}
