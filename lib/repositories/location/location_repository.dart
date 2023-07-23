import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:dating_app/repositories/location/base_location_repository.dart';

import '../../models/location_model.dart';

class LocationRepository extends BaseLocationRepository {
  final String key = 'api-key';
  final String types = 'geocode';

  @override
  Future<Location> getLocation(String location) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=place_id%2Cname%2Cgeometry&input=$location&inputtype=textquery&key=AIzaSyD_-IyeLpwkHyZJVZ9krwNJwCPIcx8gc48';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['candidates'][0] as Map<String, dynamic>;
    return Location.fromJson(results);
  }
}
