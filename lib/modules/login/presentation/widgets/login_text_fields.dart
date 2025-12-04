import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';

class LoginTextFields extends StatelessWidget {
  final LoginController controller;

  const LoginTextFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller.username,
          decoration: InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: controller.password,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
        ),
      ],
    );
  }
}
