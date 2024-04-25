import 'package:ergata/constants/colors.dart';
import 'package:ergata/models/therapist_model.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatefulWidget {
  const DoctorCard({
    super.key,
    required this.doctor,
    this.showAbout = true,
    this.showMoreInformation = true,
  });

  final MyTherapist doctor;
  final bool showAbout;
  final bool showMoreInformation;

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final moreInformation = [
      {
        'icon': Icons.account_circle_outlined,
        'label': 'Patients',
        'value': widget.doctor.rating,
      },
      {
        'icon': Icons.star_border,
        'label': 'Experience',
        'value': '3 years',
      },
      {
        'icon': Icons.favorite_border,
        'label': 'Rating',
        'value': widget.doctor.rating,
      },
      {
        'icon': Icons.numbers,
        'label': 'Reviews',
        'value': widget.doctor.rating,
      }
    ];

    return Card(
      color: Colors.transparent,
      elevation: 0.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile
          Row(
            children: [
              CircleAvatar(
                radius: 48.0,
                backgroundColor: colorScheme.background,
                backgroundImage: Image.network(widget.doctor.photo).image,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.doctor.fullName,
                      style: textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4.0),
                    Text(widget.doctor.category,
                        style: const TextStyle(
                            color: ColorsManager.secondaryColor)),
                    const SizedBox(height: 8.0),
                    const Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: ColorsManager.primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Addis Ababa, Ethiopia',
                          style: TextStyle(color: ColorsManager.secondaryColor),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(height: 32.0, color: colorScheme.surfaceVariant),
          ...widget.showAbout
              ? [
                  const Text(
                    'About',
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 8.0),
                  Text(widget.doctor.description,
                      maxLines: showAll ? null : 3,
                      style:
                          const TextStyle(color: ColorsManager.secondaryColor)),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () {
                      setState(() {
                        showAll = !showAll;
                      });
                    },
                    child: Text(
                      showAll ? 'Show less' : 'Show all',
                      style: textTheme.bodyMedium!.copyWith(
                        color: ColorsManager.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: ColorsManager.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ]
              : [],

          // More information
          ...widget.showMoreInformation
              ? [
                  Row(
                    children: moreInformation
                        .map(
                          (e) => Expanded(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: ColorsManager.primaryColor,
                                  foregroundColor: ColorsManager.secondaryColor,
                                  child: Icon(
                                    e['icon'] as IconData,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(e['value'].toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: ColorsManager.secondaryColor)),
                                const SizedBox(height: 4),
                                Text(
                                  e['label'] as String,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  )
                ]
              : []
        ],
      ),
    );
  }
}
