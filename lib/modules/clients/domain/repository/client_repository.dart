import '../../domain/entities/client.dart';

// CLASE ABSTRACTA QUE DEFINE LOS METODOS QUE DEBE IMPLEMENTAR EL REPOSITORIO DE CLIENTES
abstract class ClientRepository {
  //Future<Client> getClientById(int id);
  Future<List<Client>> getAllClients({int page = 1, int limit = 10});
  //Future<void> addClient(Client client);
  //Future<void> updateClient(Client client);
  //Future<void> deleteClient(int id);
  //Future<void> archiveClient(int id);
  //Future<void> unarchiveClient(int id);
}