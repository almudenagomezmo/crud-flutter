import 'package:crud/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';
import '../widgets/login_button.dart';
import '../widgets/login_text_fields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = LoginController();

  // Limpiar el controlador cuando se destruya el widget
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Construir la interfaz de usuario de la página de inicio de sesión
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Sign In to continue'),
              SizedBox(height: 26),

              LoginTextFields(controller: controller),

              SizedBox(height: 26),

              LoginButton(loginController: controller),

              // mostrar olvidar contraseña solo si está habilitado en AppConstants
              if (AppConstants.enableForgotPassword) ...[
                SizedBox(height: 20),
                Text("Forgot Password?"),
              ],

              // mostrar iniciar cuenta solo si está habilitado en AppConstants
              if (AppConstants.enableSignUpNewAccount) ...[
                SizedBox(height: 20),
                Text("Don't have an account? Sign Up"),
              ],
              
            ],
          ),
        ),
      ),
    );
  }
}
