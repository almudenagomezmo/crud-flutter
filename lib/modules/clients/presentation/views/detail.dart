import 'package:crud/includes/pages/barra_superior.dart';
import 'package:crud/modules/clients/presentation/controllers/client_controller.dart';
import 'package:crud/modules/clients/presentation/widgets/avatar_card.dart';
import 'package:crud/modules/clients/presentation/widgets/detail_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Detail extends StatelessWidget {
  const Detail({super.key, required String clientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarraSuperiorPersonalizada(titulo: 'Detalle del Cliente'),
      body: Consumer<ClientController>(
        builder: (context, controller, child) {
          // 1. Obtener el ID y el Cliente
          final int clientId = ModalRoute.of(context)!.settings.arguments as int;
          final client = controller.getClient(clientId);

          if (client == null) {
            return const Center(child: Text('Cliente no encontrado.'));
          }

          final String clientName = client.name;
          final String clientEmail = client.email;
          
          // Generar el texto del avatar (iniciales)
          final String avatarText = clientName.length >= 2 
              ? clientName.substring(0, 2).toUpperCase() 
              : clientName.toUpperCase();
          
          // URL de imagen de ejemplo (si tu modelo Client tuviera una propiedad imageUrl)
          // final String clientImageUrl = client.imageUrl ?? '';

          return SingleChildScrollView( // Usamos SingleChildScrollView por si la pantalla tiene más campos
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Centrar el avatar
              children: [
                
                // 1. SECCIÓN DE AVATAR / IMAGEN
                AvatarCard(
                  name: clientName,
                  initials: avatarText,
                ),

                const SizedBox(height: 30),

                // 2. DETALLES DEL CLIENTE (Usamos Cards o ListTiles para mejor estética)
                DetailCard(
                  title: clientName,
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 10),
                
                DetailCard(
                  title: clientEmail,
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 10),
                
                // 3. BOTÓN DE ACCIÓN (Ej: Editar)
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // todo Navegar a la pantalla de edición, pasando el cliente ID
                      //Navigator.pushNamed(context, '/client/edit', arguments: clientId);
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Editar Cliente', style: TextStyle(fontSize: 18)),
                  
                  ),
                ),

              ],
            ),
          );
        },
      ),
    );
  }

}