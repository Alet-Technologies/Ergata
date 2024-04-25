// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:ergata/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ergata/constants/colors.dart';
import 'package:ergata/models/patient_model.dart';
import 'package:ergata/screens/complete_profile/complete_patient/complete_profile_patient.dart';
import 'package:ergata/screens/home/home_screen_patient/chat_screen.dart';
import 'package:ergata/screens/home/home_screen_patient/home_screen.dart';
import 'package:ergata/screens/home/home_screen_patient/profile_screen.dart';
import 'package:ergata/screens/home/home_screen_patient/search_screen.dart';
import 'package:ergata/screens/home/home_screen_patient/venting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePagePatient extends StatefulWidget {
  const HomePagePatient({super.key, required this.patient});

  final MyPatient patient;

  @override
  State<HomePagePatient> createState() => _HomePage();
}

class _HomePage extends State<HomePagePatient> {
  late List screens;
  int selected = 0;

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreenPatient(patient: widget.patient),
      ChatScreenPatient(patient: widget.patient),
      SearchScreenPatient(patient: widget.patient),
      VentingScreen(),
      ProfilePatient(patient: widget.patient)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccessPatient) {
          if (state.patient.age == "" || state.patient.age == "") {
            setState(() {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CompleteProfilePatient(
                          patient: widget.patient,
                        )),
              );
            });
          }
        }
      },
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 245, 245, 245),
          body: screens[selected],
          bottomNavigationBar: DotNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: selected,
              onTap: (value) {
                setState(() {
                  selected = value;
                });
              },
              items: [
                DotNavigationBarItem(
                    icon: const Icon(Icons.home_outlined),
                    selectedColor: ColorsManager.primaryColor,
                    unselectedColor: ColorsManager.secondaryColor),
                DotNavigationBarItem(
                    icon: const Icon(Icons.chat_outlined),
                    selectedColor: ColorsManager.primaryColor,
                    unselectedColor: ColorsManager.secondaryColor),
                DotNavigationBarItem(
                    icon: const Icon(Icons.explore_outlined),
                    selectedColor: ColorsManager.primaryColor,
                    unselectedColor: ColorsManager.secondaryColor),
                DotNavigationBarItem(
                    icon: const Icon(Icons.group_outlined),
                    selectedColor: ColorsManager.primaryColor,
                    unselectedColor: ColorsManager.secondaryColor),
                DotNavigationBarItem(
                    icon: const Icon(Icons.person_outline),
                    selectedColor: ColorsManager.primaryColor,
                    unselectedColor: ColorsManager.secondaryColor),
              ])),
    );
  }
}
