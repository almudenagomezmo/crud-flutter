import 'package:crud/modules/clients/data/datasource/client_data_sources.dart';
import 'package:crud/modules/clients/domain/entities/client.dart';
import 'package:crud/modules/clients/domain/repository/client_repository.dart';

class ClientRepositoryImpl implements ClientRepository {
  // Inyección de dependencia de la fuente de datos
  final ClientDataSources clientDataSource; 

  ClientRepositoryImpl({required this.clientDataSource});

  @override
  Future<List<Client>> getAllClients({int page = 1, int limit = 10}) async {
    // Llama al DataSource (que ahora usa SQLite)
    final clientModels = await clientDataSource.fetchAllClients(); 
    
    // Convierte los modelos a entidades (Entity) y los retorna al Domain/Use Case
    return clientModels.map((model) => model.toEntity()).toList(); 
  }
}