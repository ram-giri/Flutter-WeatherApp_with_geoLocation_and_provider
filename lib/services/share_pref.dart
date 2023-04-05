import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabase {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void saveData(String location) async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove('location');
    prefs.setString('location', location);
  }

  Future<String?> getData() async {
    final prefs = await _prefs;
    return prefs.getString('location');
  }
}