import 'package:flutter/material.dart';
import 'package:sky_pulse/screens/city_screen.dart';

class ErrorScreen extends StatelessWidget {
  final String message;

  const ErrorScreen({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(190, 56, 59, 1),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const CityScreen(),
              ),
              (route) => false,
            );
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/error.jpg",
              fit: BoxFit
                  .contain, // Ajusta a imagem para caber na tela sem cortar
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
