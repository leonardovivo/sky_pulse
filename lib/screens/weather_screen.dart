import 'package:flutter/material.dart';
import 'package:sky_pulse/models/weather_model.dart';
import 'package:sky_pulse/services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({required this.cityName, super.key});

  final String cityName;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Weather> futureWeather;
  final WeatherService _weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    futureWeather = _weatherService.fetchWeatherByCityName(widget.cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/the_background.jpeg",
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
                        Text(
                          'Latest ${widget.cityName} information',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          'covered by API',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white.withOpacity(0.8),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: FutureBuilder<Weather>(
                      future: futureWeather,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData) {
                          return const Center(
                            child: Text('No data found'),
                          );
                        } else {
                          var weather = snapshot.data!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildWeatherInfo(
                                'City',
                                weather.cityName,
                              ),
                              _buildWeatherInfo(
                                'Climate conditions',
                                weather.description,
                              ),
                              _buildWeatherInfo(
                                'Current temperature',
                                '${weather.temp}°C',
                              ),
                              _buildWeatherInfo(
                                'Thermal sensation',
                                '${weather.feelsLike}°C',
                              ),
                              _buildWeatherInfo(
                                'Minimum temperature',
                                '${weather.tempMin}°C',
                              ),
                              _buildWeatherInfo(
                                'Maximum temperature',
                                '${weather.tempMax}°C',
                              ),
                              _buildWeatherInfo(
                                'Moisture',
                                '${weather.humidity}%',
                              ),
                              _buildWeatherInfo(
                                'Pressure',
                                '${weather.pressure} hPa',
                              ),
                              _buildWeatherInfo(
                                'Wind',
                                '${weather.windSpeed} m/s',
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
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
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16.0),
        const Divider(),
      ],
    );
  }
}
