import 'package:flutter_test/flutter_test.dart';
import 'package:market_list/model/dados_model.dart';

void main() {
  group('Dado Model', () {
    test('Deve criar um objeto Dado corretamente', () {
      final dado = Dado(
        descricao: 'Descrição de teste',
        valor: '100.00',
        quantidade: '2',
      );

      expect(dado.descricao, 'Descrição de teste');
      expect(dado.valor, '100.00');
      expect(dado.quantidade, '2');
    });

    test('Deve converter para Map corretamente', () {
      final dado = Dado(
        descricao: 'Teste',
        valor: '50.00',
        quantidade: '1',
      );

      final map = dado.toMap();
      expect(map['descricao'], 'Teste');
      expect(map['valor'], '50.00');
      expect(map['quantidade'], '1');
    });
  });


}