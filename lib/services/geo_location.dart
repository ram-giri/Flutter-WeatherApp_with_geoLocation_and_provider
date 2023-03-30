import 'package:geolocator/geolocator.dart';

Future<String> getLocation() async {
  Position position = await _determinePosition();
  var lat = position.latitude;
  var lon = position.longitude;
  return '$lat,$lon';
}

Future<Position> _determinePosition() async {
  LocationPermission permission;

  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location Permissions are denied');
    }
  }

  return await Geolocator.getCurrentPosition();
}

