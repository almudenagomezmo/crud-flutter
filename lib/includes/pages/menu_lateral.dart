import 'package:flutter/material.dart';

// Lo definimos como un StatelessWidget para que sea reutilizable
class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {

    final Color primaryThemeColor = Theme.of(context).colorScheme.primary;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // El DrawerHeader es opcional, pero recomendado
          DrawerHeader(
            decoration: BoxDecoration(
              // USAMOS EL COLOR OBTENIDO DEL TEMA
              color: primaryThemeColor,
            ),
            child: Text(
              'Menú',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          //DASHBOARD
          ListTile(
            leading: Icon(Icons.dashboard,color: primaryThemeColor,),
            title: const Text('Dashboard'),
            onTap: () {
              // ENLACE A LA PÁGINA DE DASHBOARD
              Navigator.pushReplacementNamed(context, '/dashboard');
            },
          ),
          //MENU DE CLIENTES
          ListTile(
            leading: Icon(Icons.group,color: primaryThemeColor,),
            title: const Text('Clientes'),
            onTap: () {
              //Cierra el menú lateral primero.
              Navigator.pop(context);

              // Navega y reemplaza la ruta actual.
              Navigator.pushReplacementNamed(context, '/clients');
            },
          ),
        ],
      ),
    );
  }
}
