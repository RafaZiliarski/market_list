import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:market_list/model/coin_data.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://economia.awesomeapi.com.br')
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('/json/last/USD-BRL')
  Future<CoinData> getCoinData();
}