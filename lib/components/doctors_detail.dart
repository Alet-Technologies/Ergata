import 'package:ergata/components/app_icon_button.dart';
import 'package:ergata/components/doctor_card.dart';
import 'package:ergata/constants/colors.dart';
import 'package:ergata/helpers/custom_string_day.dart';
import 'package:ergata/helpers/working_hours.dart';
import 'package:ergata/models/therapist_model.dart';
import 'package:flutter/material.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({
    super.key,
    required this.doctor,
  });

  final MyTherapist doctor;

  @override
  Widget build(BuildContext context) {
    return DoctorDetailsView(doctor: doctor);
  }
}

class DoctorDetailsView extends StatelessWidget {
  const DoctorDetailsView({super.key, required this.doctor});

  final MyTherapist doctor;

  @override
  Widget build(BuildContext context) {
    const colorScheme = ColorsManager.primaryColor;

    // Create the UI here
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme,
          automaticallyImplyLeading: false,
          leading: AppIconButton(
            icon: Icons.arrow_back,
            onTap: () => Navigator.pop(context),
          ),
          title: const Text(
            'Therapist Details',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            AppIconButton(
              icon: Icons.favorite_outline,
              onTap: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DoctorCard(doctor: doctor),
              const Divider(height: 32.0, color: colorScheme),
              const _DoctorWorkingHours(
                  workingHours: DoctorWorkingHours.sampleDoctorWorkingHours),
            ],
          ),
        ));
  }
}

class _DoctorWorkingHours extends StatelessWidget {
  const _DoctorWorkingHours({
    required this.workingHours,
  });

  final List<DoctorWorkingHours> workingHours;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Working Hours',
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        ListView.separated(
          padding: const EdgeInsets.all(8.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: workingHours.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8.0),
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: Text(workingHours[index].dayOfWeek),
                ),
                const SizedBox(width: 16.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorsManager.secondaryColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(workingHours[index].startTime.toCustomString(),
                      style:
                          const TextStyle(color: ColorsManager.primaryColor)),
                ),
                const SizedBox(width: 16.0),
                const Text("-"),
                const SizedBox(width: 16.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorsManager.secondaryColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(workingHours[index].endTime.toCustomString(),
                      style:
                          const TextStyle(color: ColorsManager.primaryColor)),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
