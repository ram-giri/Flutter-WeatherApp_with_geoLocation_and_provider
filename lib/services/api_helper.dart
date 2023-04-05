import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/geo_location.dart';
import 'package:weather_app/models/models.dart';
import 'package:weather_app/services/share_pref.dart';

// String? location;
String api = '1bc0383d81444b58b1432929200711';

class ApiHelper {
  Future<Weather> getData(String? city) async {
    String location = '';
    String? saveLocation = await LocalDatabase().getData();
    if (city!.isNotEmpty) {
      location = city;
    } else if (saveLocation != null) {
      location = saveLocation;
    } else {
      location = await getLocation();
    }
    return fetchApi(location);
  }
}

Future<Weather> fetchApi(String location) async {
  final url =
      'http://api.weatherapi.com/v1/current.json?key=$api&q=$location';
  var response = await http.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return Weather.fromMap(body);
    } else {
      throw Exception();
    }
  } catch (e) {
    throw e.toString();
  }
}
