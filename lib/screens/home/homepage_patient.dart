// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:ergata/constants/colors.dart';
import 'package:ergata/models/patient_model.dart';
import 'package:ergata/screens/home/home_screen_patient/chat_screen.dart';
import 'package:ergata/screens/home/home_screen_patient/home_screen.dart';
import 'package:ergata/screens/home/home_screen_patient/search_screen.dart';
import 'package:flutter/material.dart';

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
      SearchScreenPatient(patient: widget.patient),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[selected],
        bottomNavigationBar: SafeArea(
          child: DotNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: selected,
              onTap: (value) {
                setState(() {
                  selected = value;
                });
              },
              items: [
                DotNavigationBarItem(
                    icon: const Icon(Icons.home),
                    selectedColor: ColorsManager.primaryColor,
                    unselectedColor: ColorsManager.secondaryColor),
                DotNavigationBarItem(
                    icon: const Icon(Icons.chat),
                    selectedColor: ColorsManager.primaryColor,
                    unselectedColor: ColorsManager.secondaryColor),
                DotNavigationBarItem(
                    icon: const Icon(Icons.search),
                    selectedColor: ColorsManager.primaryColor,
                    unselectedColor: ColorsManager.secondaryColor),
                DotNavigationBarItem(
                    icon: const Icon(Icons.person),
                    selectedColor: ColorsManager.primaryColor,
                    unselectedColor: ColorsManager.secondaryColor),
              ]),
        ));
  }
}
