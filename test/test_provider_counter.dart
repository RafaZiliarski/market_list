import 'package:flutter_test/flutter_test.dart';
import 'package:market_list/provider/counter_controller.dart';

void main() {
  group('CounterProviderController', () {
    late CounterProviderController controller;

    setUp(() {
      // Inicializa o controller antes de cada teste
      controller = CounterProviderController();
    });

    test('Inicializa o contador com 0', () {
      expect(controller.counter, equals(0));
    });

    test('Incrementa o contador', () {
      controller.increment();
      expect(controller.counter, equals(1));
    });

    test('Decrementa o contador', () {
      controller.increment(); // Incrementa primeiro para evitar o decremento abaixo de 0
      controller.decrement();
      expect(controller.counter, equals(0));
    });

    test('Decrementa o contador, mas não permite valores negativos', () {
      controller.decrement();
      expect(controller.counter, equals(0));
    });

    test('Zera o contador', () {
      controller.increment(); // Incrementa primeiro para testar o zerar
      controller.zerar();
      expect(controller.counter, equals(0));
    });

    test('Notifica os ouvintes ao incrementar', () {
      bool notified = false;

      controller.addListener(() {
        notified = true;
      });

      controller.increment();

      expect(notified, isTrue);
    });

    test('Notifica os ouvintes ao decrementar', () {
      bool notified = false;

      controller.addListener(() {
        notified = true;
      });

      controller.decrement();

      expect(notified, isTrue);
    });

    test('Notifica os ouvintes ao zerar', () {
      bool notified = false;

      controller.addListener(() {
        notified = true;
      });

      controller.zerar();

      expect(notified, isTrue);
    });
  });
}