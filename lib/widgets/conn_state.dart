import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../config/routes.dart';

enum ConnectivityStatus {
  checking,
  offline,
  online,
}

class ConnStatus extends StatefulWidget {
  ConnStatus({super.key, this.callback});

  Function(ConnectivityStatus status)? callback;

  @override
  State<ConnStatus> createState() => _ConnStatusState();
}

class _ConnStatusState extends State<ConnStatus> {
  final Connectivity _connectivity = Connectivity();
  ConnectivityStatus _connectivityStatus = ConnectivityStatus.checking;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  void checkConnectivity() async {
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();

    setState(() {
      if (result.contains(ConnectivityResult.none)) {
        _connectivityStatus = ConnectivityStatus.offline;
      } else {
        _connectivityStatus = ConnectivityStatus.online;
      }
    });

    widget.callback?.call(_connectivityStatus);
  }

  @override
  Widget build(BuildContext context) {
    return switch (_connectivityStatus) {
      ConnectivityStatus.checking => const Text('Checando...'),
      ConnectivityStatus.offline => ElevatedButton(
        onPressed: () {
            checkConnectivity();
          },
        child: const Text("Offline"),
      ),
      ConnectivityStatus.online =>  ElevatedButton(
        onPressed: () {
            checkConnectivity();
          },
        child: const Text("Online"),
      ),
    };
  }
}
