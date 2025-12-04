// ...existing code...
import 'package:flutter/material.dart';

class BarraSuperior extends StatelessWidget implements PreferredSizeWidget {
  const BarraSuperior({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Mi Aplicación'),
      centerTitle: true,
      elevation: 2,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: 'Configuración',
          onPressed: () {
            // Navega a una pantalla de configuración; registra la ruta '/settings' en main.dart
            Navigator.pushNamed(context, '/settings');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class BarraSuperiorPersonalizada extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;

  const BarraSuperiorPersonalizada({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titulo),
      centerTitle: true,
      elevation: 2,
      actions: [
        IconButton(
          icon: const Icon(Icons.home),
          tooltip: 'Inicio',
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/dashboard');
          },
        ),
        
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
// ...existing code...