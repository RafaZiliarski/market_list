import 'package:get/get.dart';
import 'package:market_list/model/coin_data.dart';
import 'package:market_list/source/remote/rest_client.dart';

class RestRepositoryImpl implements RestRepository {
  final RestClient _restClient;

  // Construtor agora recebe o RestClient
  RestRepositoryImpl(this._restClient);

  @override
  Future<CoinData> getCoinConverted() {
    // Faz a chamada ao método da API usando o RestClient
    return _restClient.getCoinData();
  }
}

abstract class RestRepository {
  Future<CoinData> getCoinConverted();
}


