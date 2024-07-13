import 'package:flutter/material.dart';
import 'package:sky_pulse/screens/city_screen.dart';

void main() {
  runApp(const SkyPulse());
}

class SkyPulse extends StatelessWidget {
  const SkyPulse({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sky Pulse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SkyPulseHomePage(),
    );
  }
}

class SkyPulseHomePage extends StatelessWidget {
  const SkyPulseHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CityScreen();
  }
}
