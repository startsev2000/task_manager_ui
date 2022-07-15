import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_task_flutter/ui/tasks.dart';

void main() async {
  bool hasInternetConnection = await _hasInternetConnection();
  runApp(
    MyApp(
      hasInternetConnection: hasInternetConnection,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool hasInternetConnection;

  const MyApp({
    Key? key,
    required this.hasInternetConnection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (hasInternetConnection) {
      return ProviderScope(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: const Tasks(),
        ),
      );
    }
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text("No internet connection!"),
        ),
      ),
    );
  }
}

Future<bool> _hasInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException {
    return false;
  }
}
