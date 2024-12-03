import 'package:flutter_test/flutter_test.dart';
import 'package:market_list/model/coin_data.dart';

void main() {
  group('CoinData', () {
    test('Deve deserializar corretamente de um JSON válido', () {
      // JSON mockado representando a resposta da API
      final mockJson = {
        "USDBRL": {
          "code": "USD",
          "codein": "BRL",
          "name": "Dólar Comercial",
          "high": "5.123",
          "low": "5.001",
          "varBid": "0.010",
          "pctChange": "0.2",
          "bid": "5.050",
          "ask": "5.060",
          "timestamp": "1672531200",
          "create_date": "2023-01-01"
        }
      };

      // Executa a deserialização
      final coinData = CoinData.fromJson(mockJson);

      // Verifica os valores
      expect(coinData.code, "USD");
      expect(coinData.codein, "BRL");
      expect(coinData.name, "Dólar Comercial");
      expect(coinData.high, 5.123);
      expect(coinData.low, 5.001);
      expect(coinData.varBid, "0.010");
      expect(coinData.pctChange, "0.2");
      expect(coinData.bid, 5.050);
      expect(coinData.ask, 5.060);
      expect(coinData.timestamp, "1672531200");
      expect(coinData.createDate, "2023-01-01");
    });

    test('Deve lidar com valores nulos no JSON', () {
      final mockJson = {
        "USDBRL": {
          "code": null,
          "codein": null,
          "name": null,
          "high": null,
          "low": null,
          "varBid": null,
          "pctChange": null,
          "bid": null,
          "ask": null,
          "timestamp": null,
          "create_date": null
        }
      };

      final coinData = CoinData.fromJson(mockJson);

      // Verifica se os valores são nulos
      expect(coinData.code, isNull);
      expect(coinData.high, isNull);
    });

    test('Deve serializar corretamente para JSON', () {
      final coinData = CoinData(
        code: "USD",
        codein: "BRL",
        name: "Dólar Comercial",
        high: 5.123,
        low: 5.001,
        varBid: "0.010",
        pctChange: "0.2",
        bid: 5.050,
        ask: 5.060,
        timestamp: "1672531200",
        createDate: "2023-01-01",
      );

      final json = coinData.toJson();

      expect(json, {
        "code": "USD",
        "codein": "BRL",
        "name": "Dólar Comercial",
        "high": 5.123,
        "low": 5.001,
        "varBid": "0.010",
        "pctChange": "0.2",
        "bid": 5.050,
        "ask": 5.060,
        "timestamp": "1672531200",
        "createDate": "2023-01-01"
      });
    });
  });
}