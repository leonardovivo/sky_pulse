import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Text(
            'Welcome',
            style: TextStyle(
              color: Color.fromARGB(255, 2, 179, 255),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/logotipo.png'),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: TextField(
                  controller: _textFieldController.controller,
                  decoration: const InputDecoration(
                    labelText: 'Digite a cidade...',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                print(
                    'Texto inserido: ${_textFieldController.controller.text}');
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    Color.fromARGB(255, 2, 179, 255)),
              ),
              child: Text(
                'Informar clima',
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
  }
}
