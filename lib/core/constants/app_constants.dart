import 'package:flutter/material.dart';

class AppConstants {
  // Textos fijos
  static const appTitle = "CRUD Flutter App";
  static const supportEmail = "soporte@miapp.com";

  // Estilos
  static const double padding = 20.0;
  static const double buttonHeight = 50.0;

  // Rutas API
  static const String apiUrl = "https://miapi.com";

  static const bool isProduction = bool.fromEnvironment('dart.vm.product');

  static const bool enableForgotPassword = false;
  static const bool enableSignUpNewAccount = false;

  static const primaryColor = Colors.purple;
}
