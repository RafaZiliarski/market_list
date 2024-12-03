import 'package:get/get.dart';
import 'package:market_list/controllers/rest_controller.dart';
import 'package:market_list/source/remote/rest_client.dart';
import 'package:market_list/repositories/rest_repository.dart';
import 'package:dio/dio.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    // Primeiro, registre o RestClient
    Get.put(RestClient(Dio()));

    // Depois, registre o RestRepository, que depende do RestClient
    Get.put<RestRepository>(RestRepositoryImpl(Get.find<RestClient>()));

    // Por fim, registre o RestController, que depende do RestRepository
    Get.put(RestController(repository: Get.find<RestRepository>()));
  }
}