import 'package:ergata/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ergata/constants/colors.dart';
import 'package:ergata/screens/home/homepage_patient.dart';
import 'package:ergata/screens/home/homepage_therapist.dart';
import 'package:ergata/screens/signIn/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccessPatient) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePagePatient(
                        patient: state.patient,
                      )));
        } else if (state is AuthenticationSuccessTherapist) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePageTherapist(
                        therapist: state.therapist,
                      )));
        } else if (state is UnAuthenticated) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: Image.asset('assets/images/ergata.png')),
              const SizedBox(
                height: 100,
              ),
              const CircularProgressIndicator(
                color: ColorsManager.primaryColor,
                strokeWidth: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
