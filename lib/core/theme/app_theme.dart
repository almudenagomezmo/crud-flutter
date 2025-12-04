import 'package:flutter/material.dart';

class AppTheme {
  // Definimos una constante para el color principal
  static const MaterialColor primaryColor = Colors.deepOrange;

  static final mainTheme = ThemeData(
    // 1. Usamos primarySwatch para generar la paleta de tonos de rojo
    primarySwatch: primaryColor,
    
    // 2. Definimos colorScheme (Método preferido en Flutter moderno)
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: primaryColor, // Color principal de la paleta
      // Si quieres que el fondo de los Scaffold sea diferente al blanco:
      // backgroundColor: Colors.white, 
    ).copyWith(
        // Color principal usado para botones, AppBar, etc.
        primary: primaryColor, 
        // Color de énfasis (para iconos, selecciones, etc.)
        secondary: Colors.redAccent, 
    ),

    // 3. Configuramos el AppBarTheme globalmente
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor, // Color de fondo de todos los AppBars
      foregroundColor: Colors.white, // Color de los iconos y texto en el AppBar
      elevation: 4,
    ),

    // 4. (Opcional) Configuramos botones y otros elementos para usar el tema
    buttonTheme: const ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}