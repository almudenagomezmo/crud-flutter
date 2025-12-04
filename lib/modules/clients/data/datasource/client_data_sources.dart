import '../models/client_model.dart';
import 'package:crud/core/services/database_service.dart';

abstract class ClientDataSources {
  Future<List<ClientModel>> fetchAllClients();
}

class ClientDataSourcesImpl implements ClientDataSources {
  final DatabaseService dbService; // Inyección de dependencia

  // El constructor recibe el servicio de BBDD
  ClientDataSourcesImpl({required this.dbService});

  @override
  Future<List<ClientModel>> fetchAllClients() async {
    // 1. Obtiene la conexión a la base de datos
    final db = await dbService.database;

    String sql = 'SELECT * FROM clients';

    // 2. Ejecuta la consulta SQL
    final List<Map<String, dynamic>> maps = await db.rawQuery(sql);

    // 3. Mapea el resultado (Map) a la lista de ClientModel
    return List.generate(maps.length, (i) {
      return ClientModel.fromMap(maps[i]);
    });
  }

}