import 'package:flutter/material.dart';

class TextFieldController {
  final TextEditingController controller = TextEditingController();

  void dispose() {
    controller.dispose();
  }
}
