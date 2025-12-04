import 'package:flutter/material.dart';
// Importa tus vistas/páginas aquí
import 'package:crud/modules/clients/presentation/views/list.dart';
import 'package:crud/modules/dashboard/presentation/views/dashboard.dart';
import 'package:crud/modules/login/presentation/views/login_page.dart';
import 'package:crud/modules/clients/presentation/views/detail.dart';

class RouteGenerator {

  // Función estática que es llamada por onGenerateRoute
  static Route<dynamic> generateRoute(RouteSettings settings) {

    // 1. Obtiene el nombre de la ruta a la que se intenta navegar
    final name = settings.name;

    // 2. Obtiene los argumentos pasados (si existen)
    final args = settings.arguments;

    switch (name) {
      case '/':
        return _materialPageRoute(const LoginPage()); // Ruta raíz
      case '/dashboard':
        return _materialPageRoute(const Dashboard());
      case '/clients':
        // Ejemplo de ruta sin argumentos complejos (solo el widget)
        return _materialPageRoute(const List());

      // Ejemplo de ruta que espera un argumento
      case '/clients/detail':
        // 3. Puedes comprobar el tipo de argumento
        if (args is String) {
          // Si es un String (por ejemplo, el ID del cliente)
          // Puedes pasarlo al constructor de tu widget
          // pasamos el ID del cliente al Detail
          return _materialPageRoute(Detail(clientId: args.toString()));
        }
        // Si no se cumplen las condiciones, puedes retornar una página de error
        return _errorRoute();

      default:
        // 4. Ruta por defecto para manejar rutas no definidas
        return _errorRoute();
    }
  }

  // --- Funciones Auxiliares ---

  // Crea una página de error simple para rutas no encontradas
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("Error")),
          body: const Center(
            child: Text("ERROR: Ruta no encontrada."),
          ),
        );
      },
    );
  }

  // Wrapper para simplificar la creación de MaterialPageRoute
  static Route<dynamic> _materialPageRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}