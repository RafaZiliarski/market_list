import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../model/dados_model.dart';

class DatabaseHelper {
  static const _databaseName = "meu_banco.db";
  static const _databaseVersion = 1;

  static const table = 'dados';
  static const columnId = 'id';
  static const columnDescricao = 'descricao';
  static const columnValor = 'valor';
  static const columnQuantidade = 'quantidade';

  // Criar uma instância do banco de dados
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializar o banco de dados
  _initDatabase() async {
    String path = await getDatabasesPath() + _databaseName;
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // Criar tabela no banco de dados
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnDescricao TEXT NOT NULL,
        $columnValor TEXT NOT NULL,
        $columnQuantidade TEXT NOT NULL
      )
    ''');
  }

  // Inserir um dado no banco
  Future<int> insertDado(Dado dado) async {
    Database db = await database;
    return await db.insert(table, dado.toMap());
  }

  // Atualizar um dado no banco
  Future<int> updateDado(Dado dado) async {
    Database db = await database;
    return await db.update(
      table,
      dado.toMap(),
      where: '$columnId = ?',
      whereArgs: [dado.id],
    );
  }

  // Buscar todos os dados
  Future<List<Dado>> getAllDados() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return Dado.fromJson(maps[i]);
    });
  }

  // Excluir um único dado pelo ID
  Future<int> deleteDado(int id) async {
    Database db = await database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Excluir todos os dados
  Future<int> deleteAllDados() async {
    Database db = await database;
    return await db.delete(table);
  }
}