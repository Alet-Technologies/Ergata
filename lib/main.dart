import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Scaffold(
            appBar: AppBar(title: const Text("Ergata")),
            body: const Center(
              child: Text("Hello there"),
            ),
          ),
        ),
      ),
    );
  }
}
