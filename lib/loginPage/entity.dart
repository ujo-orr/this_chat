import 'package:flutter/material.dart';

class LoginEntity {
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  void dispose() {
    idController.dispose();
    pwController.dispose();
  }
}
