import 'package:crud/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:crud/core/helpers/notification_helper.dart';

class LoginController {
  final username = TextEditingController();
  final password = TextEditingController();

  void login(BuildContext context) {

    // VALIDACIONES Y LÓGICA DE AUTENTICACIÓN AQUÍ
    if (AppConstants.isProduction) {
      // lógica de producción
    } else {
      // lógica de desarrollo
      if (username.text == "admin" && password.text == "admin") {
        // login exitoso
        NotificationHelper.generarNotificacion(
          context,
          "Login exitoso",
          exito: true,
        );

        // redirigimos al listado de clientes
        Navigator.pushReplacementNamed(context, '/dashboard'); // redirigimos al dashboard
        
      } else {
        // login fallido
        NotificationHelper.generarNotificacion(
          context,
          "Credenciales inválidas",
          exito: false,
        );
      }
    }
  }

  void dispose() {
    username.dispose();
    password.dispose();
  }

  
}
