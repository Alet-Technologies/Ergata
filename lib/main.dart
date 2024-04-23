import 'package:ergata/app_view.dart';
import 'package:ergata/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ergata/firebase_options.dart';
import 'package:ergata/repository/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // runApp(MainApp());
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        create: (context) =>
            AuthenticationBloc(authRepository: AuthRepository()),
      )
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final AuthRepository authRepository = AuthRepository();

  @override
  void initState() {
    super.initState();
    context.read<AuthenticationBloc>().add(CheckAuth());
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ergata',
      home: AppView(),
    );
  }
}
