import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// --- Imports de tu Clean Architecture ---
import 'package:crud/core/services/database_service.dart';
import 'modules/clients/data/datasource/client_data_sources.dart';
import 'modules/clients/data/repository/client_repository_impl.dart';

// Capa de Dominio
import 'modules/clients/domain/use_cases/get_all_clients.dart';
// Capa de Presentación
import 'modules/clients/presentation/controllers/client_controller.dart'; 

// --- Imports de tu aplicación ---
import 'core/theme/app_theme.dart';
import 'modules/login/presentation/views/login_page.dart';
import 'core/constants/app_constants.dart';
import 'core/routes/app_routes.dart';


void main() {

  
  // -----------------------------------------------------
  // 🔴 SOLUCIÓN DEL ERROR 'setOptions' isn't defined
  /*if (kIsWeb) {
    // 1. Usamos un cast dinámico para llamar a setOptions, que es específico de la implementación web.
    // Esto asegura la estabilidad del Web Worker.
    (databaseFactoryFfiWeb as dynamic).setOptions(
      options: {} // Dejamos las opciones vacías por ahora, pero la llamada es válida.
    );

    // 2. Asignamos la factoría de BBDD al adaptador web (esto debe ir después de setOptions)
    databaseFactory = databaseFactoryFfiWeb; 
  }*/
  // -----------------------------------------------------
  
  // 1. INICIALIZACIÓN Y ENSAMBLAJE DE DEPENDENCIAS (EL WIRING)
  
  // A. Capa de Servicios
  final databaseService = DatabaseService.instance;
  
  // B. Capa de Datos
  final clientDataSource = ClientDataSourcesImpl(dbService: databaseService);
  final clientRepositoryImpl = ClientRepositoryImpl(
    clientDataSource: clientDataSource,
  );
  
  // C. Capa de Dominio (Casos de Uso)
  final getAllClientsUseCase = GetAllClients(clientRepositoryImpl);
  
  // D. Capa de Presentación (Controller)
  final clientController = ClientController(
    getAllClientsUseCase, 
  );
  
  
  // 2. INYECCIÓN EN EL ÁRBOL DE WIDGETS
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ClientController>.value(
          value: clientController,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      theme: AppTheme.mainTheme,
      home: LoginPage(), 
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}