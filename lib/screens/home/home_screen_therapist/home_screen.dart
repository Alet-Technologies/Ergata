import 'package:ergata/components/appointment_preview.dart';
import 'package:ergata/components/circle_avata.dart';
import 'package:ergata/components/section_title.dart';
import 'package:ergata/constants/colors.dart';
import 'package:ergata/constants/doctors_category.dart';
import 'package:ergata/models/therapist_model.dart';
import 'package:flutter/material.dart';

class HomeScreenTherapist extends StatelessWidget {
  const HomeScreenTherapist({super.key, required this.therapist});

  final MyTherapist therapist;

  @override
  Widget build(BuildContext context) {
    const colorScheme = ColorsManager.primaryColor;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme,
          toolbarHeight: 80,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello ${therapist.fullName}!',
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ],
          ),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.transparent,
              ),
              onPressed: () {}),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_outlined),
            ),
            const SizedBox(width: 8.0),
          ],
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              _DoctorCategories(),
              SizedBox(height: 24.0),
              _MySchedule(),
              SizedBox(height: 24.0),
              _NearbyDoctors(),
            ],
          ),
        ));
  }
}

class _DoctorCategories extends StatelessWidget {
  const _DoctorCategories();

  final List<DoctorCategory> doctorCategories = DoctorCategory.values;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: 'Categories',
          action: 'See all',
          onPressed: () {},
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: doctorCategories
              .take(5)
              .map(
                (category) => Expanded(
                  child: CircleAvatarWithTextLabel(
                    icon: category.icon,
                    label: category.name,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _MySchedule extends StatelessWidget {
  const _MySchedule();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: 'My Schedule',
          action: 'See all',
          onPressed: () {},
        ),
        const AppointmentPreviewCard(
          appointment: [],
        ),
      ],
    );
  }
}

class _NearbyDoctors extends StatelessWidget {
  const _NearbyDoctors();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SectionTitle(
          title: 'Your clients',
          action: 'See all',
          onPressed: () {},
        ),
        const SizedBox(height: 8.0),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return Divider(
              height: 24.0,
              color: colorScheme.surfaceVariant,
            );
          },
          itemCount: [].length,
          itemBuilder: (context, index) {
            final doctor = MyTherapist.empty;
          },
        ),
      ],
    );
  }
}
