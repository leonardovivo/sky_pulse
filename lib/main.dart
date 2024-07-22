import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_pulse/bloc/weather_bloc.dart';
import 'package:sky_pulse/screens/city_screen.dart';
import 'package:sky_pulse/services/weather_service.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherBloc(weatherService: WeatherService()),
        ),
      ],
      child: const SkyPulse(),
    ),
  );
}

class SkyPulse extends StatelessWidget {
  const SkyPulse({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sky Pulse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CityScreen(),
    );
  }
}
