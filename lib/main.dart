import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:market_list/config/constants.dart';
import 'package:market_list/widgets/conn_state.dart';
import 'package:market_list/widgets/offline.dart';
import 'package:market_list/widgets/online.dart';
import 'package:provider/provider.dart';
import 'add_screen.dart';
import 'bindings/main_binding.dart';
import 'config/routes.dart';
import 'package:market_list/provider/counter_controller.dart';
import 'list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => CounterProviderController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(brightness: Brightness.light,
          primary: Colors.teal,
          onPrimary: Colors.white,
          secondary: Colors.amber,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black, seedColor: azulFraco),
        useMaterial3: true,
      ),
      initialRoute: homeRoute,
      getPages: [
        GetPage(
            name: homeRoute,
            page: () => const TelaPrincipal(),
            binding: MainBindings()),
        GetPage(name: listRoute, page: () => const ListScreen()),
        GetPage(name: addRoute, page: () => AddProductPage())
      ],
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  ConnectivityStatus _connectivityStatus = ConnectivityStatus.checking;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: azulFraco,
        title: const Text("Market List"),
        actions: [
          TextButton(
              onPressed: () {},
              child: ConnStatus(
                callback: (status) {
                  setState(() {
                    _connectivityStatus = status;
                  });
                },
              ))
        ],
      ),
      body: Center(
        child: _getCurrentWidget(),
      )
    );
  }

  Widget _getCurrentWidget() => switch (_connectivityStatus) {
    ConnectivityStatus.checking => const CircularProgressIndicator(),
    ConnectivityStatus.offline => Offline(),
    ConnectivityStatus.online => Online()
  };

}

