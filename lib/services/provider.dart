import 'package:flutter/material.dart';
import '../models/models.dart';
import 'api_helper.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? weather;
  WeatherProvider(String city) {
    getWeather(city);
  }
  Future<void> getWeather (String city)async{
    await ApiHelper().getData(city).then((value) {
      weather = value;
    notifyListeners();
    });
  }
}