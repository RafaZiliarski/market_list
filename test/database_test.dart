import 'package:flutter_test/flutter_test.dart';
import 'package:market_list/source/local/database_helper.dart';
import 'package:market_list/model/dados_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Configurar o ambiente FFI antes dos testes
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  final dbHelper = DatabaseHelper();

  group('Database Helper', () {
    test('Deve inserir um dado no banco de dados', () async {
      final dado = Dado(
        descricao: 'Produto Teste',
        valor: '100.00',
        quantidade: '2',
      );

      final id = await dbHelper.insertDado(dado);
      expect(id, isNotNull);
    });

    test('Deve recuperar dados do banco', () async {
      final dados = await dbHelper.getAllDados();
      expect(dados, isList);
      expect(dados.isNotEmpty, true);
    });

    test('Deve deletar todos os dados', () async {
      await dbHelper.deleteAllDados();
      final dados = await dbHelper.getAllDados();
      expect(dados.isEmpty, true);
    });
  });
}