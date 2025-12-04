import '../../domain/entities/client.dart';
import '../../domain/repository/client_repository.dart';

class GetAllClients {
  final ClientRepository repository;

  GetAllClients(this.repository);

  Future<List<Client>> call({int page = 1, int limit = 10}) {
    return repository.getAllClients(page: page, limit: limit);
  }
}