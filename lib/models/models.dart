class Weather {
  String name;
  String country;
  num lat;
  num lon;
  num tempC;
  num tempF;
  String conditon;
  String icon;
  Weather({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tempC,
    required this.tempF,
    required this.conditon,
    required this.icon,
  });

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      name: map['location']['name'],
      country: map['location']['country'],
      lat: map['location']['lat'],
      lon: map['location']['lon'],
      tempC: map['current']['temp_c'],
      tempF: map['current']['temp_c'],
      conditon: map['current']['condition']['text'],
      icon: map['current']['condition']['icon'],
    );
  }
}
