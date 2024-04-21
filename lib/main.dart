import 'package:flutter/material.dart';
import './screens/signIn/loginpage.dart';
import 'screens/signIn/patient_update_info.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: UpdateInfo()),
    );
  }
}
