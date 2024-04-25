import 'package:ergata/constants/colors.dart';
import 'package:ergata/models/vent_model.dart';
import 'package:flutter/material.dart';

class VentingScreen extends StatelessWidget {
  const VentingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              'Vents',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: Vent.sampleVents.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: ColorsManager.primaryColor.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Vent.sampleVents[index].content,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Vent.sampleVents[index].date,
                              style: const TextStyle(
                                  color: ColorsManager.secondaryColor,
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.comment,
                                  size: 20,
                                  color: ColorsManager.primaryColor,
                                ))
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
