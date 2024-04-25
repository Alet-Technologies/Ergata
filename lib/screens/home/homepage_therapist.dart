// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:ergata/constants/colors.dart';
import 'package:ergata/models/therapist_model.dart';
import 'package:ergata/screens/home/home_screen_therapist/chat_screen.dart';
import 'package:ergata/screens/home/home_screen_therapist/home_screen.dart';
import 'package:ergata/screens/home/home_screen_therapist/profile_screen.dart';
import 'package:flutter/material.dart';

class HomePageTherapist extends StatefulWidget {
  const HomePageTherapist({super.key, required this.therapist});

  final MyTherapist therapist;

  @override
  State<HomePageTherapist> createState() => _HomePage();
}

class _HomePage extends State<HomePageTherapist> {
  late List screens;
  int selected = 0;

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreenTherapist(therapist: widget.therapist),
      ChatScreenTherapist(therapist: widget.therapist),
      ProfileTherapist()
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
              ]),
        ));
  }
}
