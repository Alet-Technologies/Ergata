import 'package:flutter/material.dart';

enum DoctorCategory {
  psychologist(
    name: 'Psychologist',
    icon: Icons.account_circle_outlined,
  ),
  psychiatrist(
    name: 'Psychiatrists',
    icon: Icons.favorite_border_outlined,
  ),
  psychoanalyst(
    name: 'Psychoanalyst',
    icon: Icons.person_2_outlined,
  ),
  psychotherapist(
    name: 'Psychotherapist',
    icon: Icons.health_and_safety_outlined,
  ),
  counselor(
    name: 'Counselor',
    icon: Icons.local_pharmacy_outlined,
  ),
  arttherapist(
    name: 'Art Therapist',
    icon: Icons.medical_information_outlined,
  ),
  socialworker(
    name: 'Social Worker',
    icon: Icons.medical_services_outlined,
  ),
  psychiatricnurse(
    name: 'Psychiatric Nurse',
    icon: Icons.health_and_safety_outlined,
  );

  final String name;
  final IconData icon;

  const DoctorCategory({
    required this.name,
    required this.icon,
  });
}
