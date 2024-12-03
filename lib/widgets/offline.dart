import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../config/constants.dart';

class Offline extends GetView {

  @override
  Widget build(BuildContext context) {
    return
      Center(
      child: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Card(
            color: azulFraco,
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                children: [
                  const Text(
                    style: TextStyle(fontSize: 22),
                    textAlign: TextAlign.center,
                    "Para o correto funcionamento do app, o dispositivo deve estar conectado à internet!"
                  ),
                  kits[12],
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
