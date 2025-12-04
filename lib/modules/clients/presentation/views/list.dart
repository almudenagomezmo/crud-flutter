import 'package:crud/includes/pages/barra_superior.dart';
import 'package:crud/includes/pages/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/client_controller.dart';

class List extends StatelessWidget {
  const List({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos el color principal de la aplicación para algunos elementos (asumiendo AppConstants.primaryColor)
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: BarraSuperiorPersonalizada(titulo: 'Clientes'),
      drawer: const MenuLateral(),
      body: Consumer<ClientController>(
        builder: (context, controller, child) {
          
          // Nota: Reemplazo `controller.getClientsList` por el nombre correcto:
          final clientsToDisplay = controller.getClientsList;

          return Column(
            children: <Widget>[
              // --- 1. CAMPO DE FILTRO (Con estilo más minimalista) ---
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar por Nombre o Email...',
                    prefixIcon: Icon(Icons.search, color: primaryColor),
                    // Diseño más limpio sin borde sólido
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true, // Fondo de color suave
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  onChanged: (value) {
                    controller.updateSearchTerm(value);
                  },
                ),
              ),

              const Divider(height: 1, thickness: 0.5), // Separador visual
              // --- 2. LISTA DE CLIENTES PAGINADA Y FILTRADA ---
              Expanded(
                child: clientsToDisplay.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_search,
                              size: 60,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              controller.searchTerm.isNotEmpty
                                  ? 'No se encontraron clientes que coincidan con "${controller.searchTerm}".'
                                  : 'No hay clientes cargados.',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: clientsToDisplay.length,
                        itemBuilder: (context, index) {
                          final client = clientsToDisplay[index];

                          String clientName = client.name;
                          String clientEmail = client.email;

                          String avatarText = clientName.length >= 2
                              ? clientName.substring(0, 2).toUpperCase()
                              : clientName.toUpperCase();

                          // Usamos un widget Card con mejor diseño y separación
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 4.0,
                            ),
                            child: Card(
                              elevation: 4, // Sombra más pronunciada
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                ), // Bordes redondeados
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(12.0),
                                leading: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: primaryColor.withOpacity(
                                    0.1,
                                  ), // Color basado en el tema
                                  child: Text(
                                    avatarText,
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  clientName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                  clientEmail,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Colors.grey[400],
                                ),
                                onTap: () {
                                  // redirigimos a la ficha del cliente

                                  //Cierra el menú lateral primero.
                                  Navigator.pop(context);

                                  // Navega a la ficha del cliente (no reemplaza la ruta,
                                  // así aparece la opción de volver atrás).
                                  Navigator.pushNamed(
                                    context,
                                    '/clients/detail',
                                    arguments: client.id,
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),

              // --- 3. CONTROLES DE PAGINACIÓN (Estilo más moderno) ---
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey[200]!, width: 1.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Botón de Retroceso
                    IconButton(
                      icon: const Icon(Icons.chevron_left, size: 28),
                      color: controller.currentPage > 1
                          ? primaryColor
                          : Colors.grey,
                      onPressed: controller.currentPage > 1
                          ? controller.goToPreviousPage
                          : null,
                    ),

                    // Indicador de Página
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'Página ${controller.currentPage} de ${controller.totalPages}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Botón de Avance
                    IconButton(
                      icon: const Icon(Icons.chevron_right, size: 28),
                      color: controller.currentPage < controller.totalPages
                          ? primaryColor
                          : Colors.grey,
                      onPressed: controller.currentPage < controller.totalPages
                          ? controller.goToNextPage
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
