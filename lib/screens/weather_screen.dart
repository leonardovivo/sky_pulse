import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_pulse/screens/city_screen.dart';
import 'package:sky_pulse/screens/error_screen.dart';
import '../bloc/weather_bloc.dart';
import 'package:page_transition/page_transition.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({required this.cityName, super.key});

  final String cityName;

  Route _createRoute(Widget screen, PageTransitionType transitionType) {
    return PageTransition(
      type: transitionType,
      child: screen,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                _createRoute(
                    const CityScreen(), PageTransitionType.leftToRight),
                (route) => false,
              );
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/background.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 35.0),
                          child: Text(
                            'Latest weather update on \n$cityName',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      if (state is WeatherLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is WeatherError) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.push(
                            context,
                            _createRoute(
                              ErrorScreen(message: state.message),
                              PageTransitionType.bottomToTop,
                            ),
                          );
                        });
                        return const SizedBox.shrink();
                      } else if (state is WeatherLoaded) {
                        var weather = state.weather;
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey),
                            color: Colors.black.withOpacity(0.8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildWeatherInfo(
                                'City:',
                                weather.cityName,
                              ),
                              _buildWeatherInfo(
                                'Climate conditions:',
                                weather.description,
                              ),
                              _buildWeatherInfo(
                                'Current temperature:',
                                '${weather.temp}°C',
                              ),
                              _buildWeatherInfo(
                                'Thermal sensation:',
                                '${weather.feelsLike}°C',
                              ),
                              _buildWeatherInfo(
                                'Minimum temperature:',
                                '${weather.tempMin}°C',
                              ),
                              _buildWeatherInfo(
                                'Maximum temperature:',
                                '${weather.tempMax}°C',
                              ),
                              _buildWeatherInfo(
                                'Moisture:',
                                '${weather.humidity}%',
                              ),
                              _buildWeatherInfo(
                                'Pressure:',
                                '${weather.pressure} hPa',
                              ),
                              _buildWeatherInfo(
                                'Wind:',
                                '${weather.windSpeed} m/s',
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('No data found'),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          value,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16.0),
        const Divider(),
      ],
    );
  }
}
