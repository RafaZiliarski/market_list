import 'package:flutter/cupertino.dart';

class CounterProviderController extends ChangeNotifier {
  int _counter = 0;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter--;
    if (_counter < 0) _counter = 0;
    notifyListeners();
  }

  void zerar() {
    _counter = 0;
    notifyListeners();
  }

  int get counter => _counter;
}