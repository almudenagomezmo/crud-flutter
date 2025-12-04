import 'dart:math';

import 'package:crud/includes/pages/barra_superior.dart';
import 'package:flutter/material.dart';
import 'package:crud/includes/pages/menu_lateral.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => DashboardState();
}

/*class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarraSuperiorPersonalizada(titulo: 'Dashboard'),
      drawer: const MenuLateral(),
      body: Center(
        child: Text(
          'Bienvenido al Dashboard',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}*/

class DashboardState extends State<Dashboard> {

  // datos para las animaciones
  double ancho = 50;
  double alto = 50;
  Color color = Colors.blue;
  BorderRadiusGeometry borderRadius = BorderRadiusGeometry.circular(8);

  // opacidad
  double opacidad = 1.0;
  void cambiarOpacidad() {
    setState(() {

      final random = Random();

            // cambiar a valores aleatorios
            ancho = random.nextInt(300).toDouble();
            alto = random.nextInt(300).toDouble();
            color = Color.fromRGBO(
              random.nextInt(256),
              random.nextInt(256),
              random.nextInt(256),
              1,
            );
            
            borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());

      opacidad = opacidad == 1.0 ? 0.0 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarraSuperiorPersonalizada(titulo: 'Dashboard'),
      drawer: const MenuLateral(),
      body: Center(
        child: AnimatedOpacity(
          opacity: opacidad,
          duration: const Duration(seconds: 2),
          child: AnimatedContainer(
            width: ancho,
            height: alto,
            decoration: BoxDecoration(
              color: color,
              borderRadius: borderRadius,
            ),
            duration: const Duration(seconds: 1),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cambiarOpacidad();
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
