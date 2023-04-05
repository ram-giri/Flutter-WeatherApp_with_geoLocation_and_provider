import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/help_screen.dart';
import 'services/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(''),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: SplashScreen(),
    );
  }
}
