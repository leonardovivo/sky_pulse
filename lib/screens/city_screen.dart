import 'package:flutter/material.dart';
import 'package:sky_pulse/screens/weather_screen.dart';
import '../controllers/text_field_controller.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final TextFieldController _textFieldController = TextFieldController();

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  void _navigateToWeatherScreen(BuildContext context) {
    String cityName = _textFieldController.controller.text.trim();

    // Limpa o campo de texto
    _textFieldController.controller.clear();

    // Navega para a tela de informações
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherScreen(cityName: cityName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/the_background.jpeg"),
                fit: BoxFit.fill,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: const Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Text(
                        'Welcome to',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    centerTitle: true,
                  ),
                  Image.asset('assets/images/logotipo.png'),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'City weather check',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 16.0, right: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: TextField(
                        controller: _textFieldController.controller,
                        decoration: const InputDecoration(
                          labelText: 'Enter a city...',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () => _navigateToWeatherScreen(context),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 2, 179, 255)),
                    ),
                    child: const Text(
                      'Check weather',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
