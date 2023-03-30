import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/geo_location.dart';
import 'package:weather_app/models/models.dart';
import 'package:weather_app/services/share_pref.dart';

String location = '';

class ApiHelper {
  Future<Weather> getData(String? city) async {
    if (city!.isNotEmpty) {
      location = city;
    } else if (await LocalDatabase().getData() != null) {
      location = (await LocalDatabase().getData())!;
    } else {
      location = await getLocation();
    }
    return fetchApi();
  }
}

Future<Weather> fetchApi() async {
  final url =
      'http://api.weatherapi.com/v1/current.json?key=1bc0383d81444b58b1432929200711&q=$location';
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
