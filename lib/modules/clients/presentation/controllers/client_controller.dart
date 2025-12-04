// lib/modules/clients/presentation/controllers/client_controller.dart

import 'package:crud/modules/clients/domain/entities/client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Importa el Caso de Uso (la única forma de acceder a los datos)
import '../../domain/use_cases/get_all_clients.dart'; 

/// Gestiona el estado de los clientes usando la Clean Architecture.
class ClientController with ChangeNotifier {
  // 1. INYECCIÓN DEL CASO DE USO
  final GetAllClients getAllClientsUseCase; 

  // --- Estado de la Carga de Datos ---
  bool _isLoading = false;
  String? _errorMessage;

  // Lista privada de CLIENT ENTITY.
  List<Client> _clients = [];

  // ... (Variables de Filtro y Paginación sin cambios)
  final int _clientsPerPage = 5;
  int _currentPage = 1;
  String _searchTerm = ''; 
  
  // --- Getters de Estado ---

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Getter de la lista, adaptado para usar Client
  List<Client> get getClientsList {
    // ... (Lógica de filtrado y paginación, adaptada para Client) ...

    List<Client> workingList;
    
    if (_searchTerm.isEmpty) {
      workingList = _clients;
    } else {
      final lowerCaseSearchTerm = _searchTerm.toLowerCase();
      // Aplica el filtro usando las propiedades de ClientEntity
      workingList = _clients.where((client) {
        final matchesName = client.name.toLowerCase().contains(lowerCaseSearchTerm);
        final matchesEmail = client.email.toLowerCase().contains(lowerCaseSearchTerm);
        return matchesName || matchesEmail;
      }).toList();
    }
    
    // Lógica de paginación (sin cambios)
    final startIndex = (_currentPage - 1) * _clientsPerPage;
    var endIndex = startIndex + _clientsPerPage;
    if (startIndex >= workingList.length) {
      return []; 
    }
    if (endIndex > workingList.length) {
      endIndex = workingList.length;
    }

    return workingList.sublist(startIndex, endIndex);
  }

  int get totalPages {
     // ... (Lógica de totalPages, adaptada para Client, sin cambios) ...
     List<Client> totalFilteredList;
     if (_searchTerm.isEmpty) {
       totalFilteredList = _clients;
     } else {
       final lowerCaseSearchTerm = _searchTerm.toLowerCase();
       totalFilteredList = _clients.where((client) {
         return client.name.toLowerCase().contains(lowerCaseSearchTerm) || 
                   client.email.toLowerCase().contains(lowerCaseSearchTerm);
       }).toList();
     }
     if (totalFilteredList.isEmpty) return 1;
     return (totalFilteredList.length / _clientsPerPage).ceil(); 
  }

  // ... (Otros Getters sin cambios) ...
  String get searchTerm => _searchTerm; 
  int get currentPage => _currentPage;
  int get clientsPerPage => _clientsPerPage;


  // 2. CONSTRUCTOR ADAPTADO PARA RECIBIR EL CASO DE USO
  ClientController(this.getAllClientsUseCase) {
    // Llamar a la función asíncrona de carga inicial
    _loadClients(); 
  }

  // --- Métodos de Acción (sin cambios) ---

  void updateSearchTerm(String newTerm) {
    _searchTerm = newTerm;
    _currentPage = 1; 
    notifyListeners(); 
  }

  void goToNextPage() {
    if (_currentPage < totalPages) {
      _currentPage++;
      notifyListeners();
    }
  }

  void goToPreviousPage() {
    if (_currentPage > 1) {
      _currentPage--;
      notifyListeners();
    }
  }

  // 3. IMPLEMENTACIÓN DE LA CARGA DE DATOS REAL
  Future<void> _loadClients() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // LLAMADA AL CASO DE USO DEL DOMINIO
      _clients = await getAllClientsUseCase.call(); 
      
    } catch (e) {
      // Manejo de errores (ej. fallo de SQLite, error de mapeo, etc.)
      _errorMessage = 'Error al cargar los clientes: ${e.toString()}';
      _clients = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Adaptación del método getClient
  Client? getClient(int id) {
    try {
      return _clients.firstWhere((client) => client.id == id);
    } catch (e) {
      return null;
    }
  }
}