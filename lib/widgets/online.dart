import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:market_list/controllers/rest_controller.dart';
import 'package:http/http.dart' as http;
import '../config/constants.dart';
import '../config/routes.dart';
import '../controllers/rest_controller.dart';
import '../main.dart';
import '../model/coin_data.dart';
import '../source/local/database_helper.dart';

class Online extends GetView<RestController> {
  Online({super.key});

  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {controller.getCoin();},
              child: const Text("Obter Cotação")
          ),
          Obx(() {
            if (controller.coinData.value == null) {
              //return const CircularProgressIndicator(); // Indicador de carregamento
            }
            final dado = controller.coinData.value;
            return Visibility(
                visible: controller.coinData.value != null,
                child: Column(
                  children: [
                    Card(
                        color: azulFraco,
                        child: Wrap(
                          children: [
                            ListTile(
                              title: Text('Código: ${dado?.code}'),
                            ),
                            ListTile(
                              title: Text('Valor Alto: ${dado?.high}'),
                            ),
                            ListTile(
                              title: Text('Valor Baixo: ${dado?.low}'),
                            ),
                          ],
                        )
                    ),
                    ElevatedButton(
                        onPressed: (){
                          Navigator.pushNamed(
                              context,
                              addRoute,
                              arguments: {
                                "high": double.tryParse(dado?.high.toString() ?? "0") ?? 0.0,
                                "low": double.tryParse(dado?.low.toString() ?? "0") ?? 0.0,
                              }
                          );
                        },
                        child: Text("Adicionar Itens")
                    )
                  ],
                )
            );
          }),
        ],
      ),
    );
  }
}
