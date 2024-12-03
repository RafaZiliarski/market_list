import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const Color azulFraco = Color(0xFF93E1FF);
const Color azulDivider = Color(0xFF5FA5C1);
const Color azulForte = Color(0xFF244FFF);
const Color cinzaFraco = Color(0xFF878484);
const Color cinzaEscuro = Color(0xFF5E5B5B);
const double iconeMedio = 30.0;

const customSwatch = MaterialColor(
  0xFFFF5252,
  <int, Color>{
    50: Color(0xFFFFEBEE),
    100: Color(0xFFCDFFF6),
    200: Color(0xFF9AE8EF),
    300: Color(0xFF73CAE5),
    400: Color(0xFF50EFA0),
    500: Color(0xFF52E5FF),
    600: Color(0xFF3573E5),
    700: Color(0xFF2F63D3),
    800: Color(0xFF005CFF),
    900: Color(0xFF0049F4),
  },
);

const List<String> titles = [
  "SpinKitRotatingCircle",
  "SpinKitRotatingPlain",
  "SpinKitChasingDots",
  "SpinKitPumpingHeart",
  "SpinKitPulse",
  "SpinKitDoubleBounce",
  "SpinKitWave",
  "SpinKitWave",
  "SpinKitWave",
  "SpinKitPianoWave",
  "SpinKitPianoWave",
  "SpinKitPianoWave",
  "SpinKitThreeBounce",
  "SpinKitThreeInOut",
  "SpinKitWanderingCubes",
  "SpinKitWanderingCubes",
  "SpinKitCircle",
  "SpinKitFadingFour",
  "SpinKitFadingFour",
  "SpinKitFadingCube",
  "SpinKitCubeGrid",
  "SpinKitFoldingCube",
  "SpinKitRing",
  "SpinKitDualRing",
  "SpinKitSpinningLines",
  "SpinKitFadingGrid",
  "SpinKitFadingGrid",
  "SpinKitSquareCircle",
  "SpinKitSpinningCircle",
  "SpinKitSpinningCircle",
  "SpinKitFadingCircle",
  "SpinKitHourGlass",
  "SpinKitPouringHourGlass",
  "SpinKitPouringHourGlassRefined",
  "SpinKitRipple",
  "SpinKitDancingSquare",
];

const kits = <Widget>[
  SpinKitRotatingCircle(color: Colors.blueAccent,),
  SpinKitRotatingPlain(color: Colors.blueAccent),
  SpinKitChasingDots(color: Colors.greenAccent),
  SpinKitPumpingHeart(color: Colors.redAccent),
  SpinKitPulse(color: Colors.redAccent),
  SpinKitDoubleBounce(color: Colors.redAccent),
  SpinKitWave(color: Colors.redAccent, type: SpinKitWaveType.start),
  SpinKitWave(color: Colors.redAccent, type: SpinKitWaveType.center),
  SpinKitWave(color: Colors.redAccent, type: SpinKitWaveType.end),
  SpinKitPianoWave(
      color: Colors.redAccent, type: SpinKitPianoWaveType.start),
  SpinKitPianoWave(
      color: Colors.redAccent, type: SpinKitPianoWaveType.center),
  SpinKitPianoWave(color: Colors.redAccent, type: SpinKitPianoWaveType.end),
  SpinKitThreeBounce(color: Colors.redAccent),
  SpinKitThreeInOut(color: Colors.redAccent),
  SpinKitWanderingCubes(color: Colors.redAccent),
  SpinKitWanderingCubes(color: Colors.redAccent, shape: BoxShape.circle),
  SpinKitCircle(color: Colors.redAccent),
  SpinKitFadingFour(color: Colors.redAccent),
  SpinKitFadingFour(color: Colors.redAccent, shape: BoxShape.rectangle),
  SpinKitFadingCube(color: Colors.redAccent),
  SpinKitCubeGrid(size: 51.0, color: Colors.redAccent),
  SpinKitFoldingCube(color: Colors.redAccent),
  SpinKitRing(color: Colors.redAccent),
  SpinKitDualRing(color: Colors.redAccent),
  SpinKitSpinningLines(color: Colors.redAccent),
  SpinKitFadingGrid(color: Colors.redAccent),
  SpinKitFadingGrid(color: Colors.redAccent, shape: BoxShape.rectangle),
  SpinKitSquareCircle(color: Colors.redAccent),
  SpinKitSpinningCircle(color: Colors.redAccent),
  SpinKitSpinningCircle(color: Colors.redAccent, shape: BoxShape.rectangle),
  SpinKitFadingCircle(color: Colors.redAccent),
  SpinKitHourGlass(color: Colors.redAccent),
  SpinKitPouringHourGlass(color: Colors.redAccent),
  SpinKitPouringHourGlassRefined(color: Colors.redAccent),
  SpinKitRipple(color: Colors.redAccent),
  SpinKitDancingSquare(color: Colors.redAccent),
];

// Map com as opções do segundo spinner baseadas no primeiro
const Map<String, List<String>> secondSpinnerOptions = {
  'Limpeza': [
    'Detergente',
    'Sabão em Pó',
    'Desinfetante',
    'Amaciante',
    'Água Sanitária'
  ],
  'Higiêne': [
    'Sabonete',
    'Creme Dental',
    'Fio Dental'
  ],
  'Alimentos': [
    'Arroz',
    'Feijão',
    'Carne',
    'Massas',
    'Pipoca'
  ],
  'Bebidas': [
    'Suco',
    'Leite',
    'Iogurte',
    'Cerveja',
    'Água'
  ]
};
