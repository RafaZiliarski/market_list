import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:market_list/model/coin_data.dart';
import 'package:get/get.dart';
import 'package:market_list/repositories/rest_repository.dart';

class RestController extends GetxController {
  final RestRepository repository;
  var coinData = Rxn<CoinData>();  // Define uma variável observável de CoinData

  // O construtor agora recebe o RestRepository
  RestController({required this.repository});

  // Função para pegar os dados da API
  Future<void> getCoin() async {
    try {
      // Chama o método do RestRepository
      CoinData data = await repository.getCoinConverted();
      coinData.value = data; // Atualiza o valor de coinData
    } catch (e) {
      print('Erro ao obter dados: $e');
      coinData.value = null; // Caso haja erro, define como null
    }
  }
}