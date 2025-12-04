import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';

class LoginButton extends StatelessWidget {
  final LoginController loginController;

  const LoginButton({super.key, required this.loginController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 49,
      child: ElevatedButton(
        onPressed: () => loginController.login(context),
        child: Text(
          'Login',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
