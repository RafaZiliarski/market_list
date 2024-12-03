// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinData _$CoinDataFromJson(Map<String, dynamic> json) => CoinData(
      code: json['code'] as String?,
      codein: json['codein'] as String?,
      name: json['name'] as String?,
      high: (json['high'] as num?)?.toDouble(),
      low: (json['low'] as num?)?.toDouble(),
      varBid: json['varBid'] as String?,
      pctChange: json['pctChange'] as String?,
      bid: (json['bid'] as num?)?.toDouble(),
      ask: (json['ask'] as num?)?.toDouble(),
      timestamp: json['timestamp'] as String?,
      createDate: json['createDate'] as String?,
    );

Map<String, dynamic> _$CoinDataToJson(CoinData instance) => <String, dynamic>{
      'code': instance.code,
      'codein': instance.codein,
      'name': instance.name,
      'high': instance.high,
      'low': instance.low,
      'varBid': instance.varBid,
      'pctChange': instance.pctChange,
      'bid': instance.bid,
      'ask': instance.ask,
      'timestamp': instance.timestamp,
      'createDate': instance.createDate,
    };
