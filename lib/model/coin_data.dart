import 'package:json_annotation/json_annotation.dart';

part 'coin_data.g.dart';

@JsonSerializable()
class CoinData {
  const CoinData({
    this.code,
    this.codein,
    this.name,
    this.high,
    this.low,
    this.varBid,
    this.pctChange,
    this.bid,
    this.ask,
    this.timestamp,
    this.createDate,
  });

  // Factory para deserializar o JSON
  factory CoinData.fromJson(Map<String, dynamic> json) {
    final usdbrl = json['USDBRL']; // A chave da cotação
    return CoinData(
      code: usdbrl['code'] as String?,
      codein: usdbrl['codein'] as String?,
      name: usdbrl['name'] as String?,
      high: (usdbrl['high'] as String?)?.replaceAll(',', '.').toDouble(),
      low: (usdbrl['low'] as String?)?.replaceAll(',', '.').toDouble(),
      varBid: usdbrl['varBid'] as String?,
      pctChange: usdbrl['pctChange'] as String?,
      bid: (usdbrl['bid'] as String?)?.replaceAll(',', '.').toDouble(),
      ask: (usdbrl['ask'] as String?)?.replaceAll(',', '.').toDouble(),
      timestamp: usdbrl['timestamp'] as String?,
      createDate: usdbrl['create_date'] as String?,
    );
  }

  // Método para serializar para JSON
  Map<String, dynamic> toJson() => _$CoinDataToJson(this);

  final String? code;
  final String? codein;
  final String? name;
  final double? high;  // Usando double para valores numéricos
  final double? low;
  final String? varBid;
  final String? pctChange;
  final double? bid;
  final double? ask;
  final String? timestamp;
  final String? createDate;
}

extension StringToDouble on String {
  double? toDouble() {
    try {
      return double.tryParse(this);
    } catch (e) {
      return null;
    }
  }
}