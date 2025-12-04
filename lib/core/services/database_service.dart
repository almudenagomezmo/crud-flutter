import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer' as developer;

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    developer.log('INICIALIZANDO DB por primera vez...', name: 'DB_STATUS');
    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // 1. Log de la ruta donde se INTENTA abrir/crear
    developer.log('RUTA ESTIMADA DE LA DB (Web): $path', name: 'DB_PATH');
    developer.log('Intentando abrir/crear DB en la ruta anterior...', name: 'DB_ACTION');

    try {
      final db = await openDatabase(
        path,
        version: 1,
        // Se añade onConfigure para posibles pragmas y traceo
        onConfigure: (db) async {
          developer.log('ON CONFIGURE: habilitando pragmas antes de abrir.', name: 'DB_STATUS');
          try {
            await db.execute('PRAGMA foreign_keys = ON');
            developer.log('PRAGMA foreign_keys habilitado.', name: 'DB_STATUS');
          } catch (e) {
            developer.log('Fallo al ejecutar PRAGMA: $e', name: 'DB_WARNING', error: e);
          }
        },
        onCreate: _createDB,
        onOpen: (db) {
          developer.log('DB ABIERTA/CONECTADA con ÉXITO.', name: 'DB_STATUS');
        }
      );
      return db;
    } catch (e) {
      // 🚨 Log del fallo de apertura/creación
      developer.log('ERROR FATAL al abrir/crear DB: $e', name: 'DB_ERROR', error: e);
      rethrow;
    }
  }

  // Creación del Esquema (común)
  Future _createDB(Database db, int version) async {
    // 2. Log de la ejecución de la creación de tablas
    developer.log('EJECUTANDO _createDB: Creando la tabla clients.', name: 'DB_STATUS');

    try {
      await db.execute('''
      CREATE TABLE clients (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');
      developer.log('Tabla clients CREADA.', name: 'DB_STATUS');
    } catch (e) {
      developer.log('ERROR creando tabla clients: $e', name: 'DB_ERROR', error: e);
      rethrow;
    }
  }
  
  /// Método de ayuda para verificar la conexión y listar tablas existentes.
  /// Úsalo desde el código (por ejemplo al iniciar) para confirmar que la DB
  /// fue creada y contiene la tabla `clients`.
  Future<List<String>> testConnection() async {
    try {
      final db = await database;
      developer.log('TEST_CONNECTION: consultando sqlite_master...', name: 'DB_TEST');
      final List<Map<String, Object?>> result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name"
      );
      final tables = result.map((r) => r['name'] as String).toList();
      developer.log('TABLAS ENCONTRADAS: $tables', name: 'DB_TEST');
      return tables;
    } catch (e) {
      developer.log('TEST_CONNECTION ERROR: $e', name: 'DB_ERROR', error: e);
      rethrow;
    }
  }
}