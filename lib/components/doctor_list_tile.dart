// ignore_for_file: use_build_context_synchronously

import 'package:ergata/components/doctors_detail.dart';
import 'package:ergata/constants/colors.dart';
import 'package:ergata/models/patient_model.dart';
import 'package:ergata/models/therapist_model.dart';
import 'package:ergata/repository/chat.dart';
import 'package:ergata/screens/chat/chatroom_patient.dart';
import 'package:ergata/service/utility.dart';
import 'package:flutter/material.dart';

class DoctorListTile extends StatelessWidget {
  const DoctorListTile({
    super.key,
    required this.doctor,
    required this.patient,
  });

  final MyTherapist doctor;
  final MyPatient patient;

  @override
  Widget build(BuildContext context) {
    final ChatRepository chatRepository = ChatRepository();
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      // Add navigation
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DoctorDetailsScreen(doctor: doctor);
            },
          ),
        );
      },
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 30.0,
        backgroundColor: ColorsManager.secondaryColor,
        child: doctor.photo == ""
            ? Image.asset(
                "assets/images/profile.png",
                fit: BoxFit.cover,
                height: 40,
                width: 40,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  doctor.photo,
                  fit: BoxFit.cover,
                  height: 60,
                  width: 60,
                ),
              ),
      ),
      title: Text(
        "Dr. ${doctor.fullName}",
        style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4.0),
          Text(doctor.category,
              style: const TextStyle(color: ColorsManager.primaryColor)),
          const SizedBox(height: 8.0),
          Row(
            children: [
              const Icon(Icons.star,
                  color: Color.fromRGBO(255, 204, 128, 1), size: 16),
              const SizedBox(width: 4.0),
              Text(doctor.rating.toInt().toString(),
                  style: const TextStyle(
                      color: ColorsManager.primaryColor,
                      fontWeight: FontWeight.bold)),
              const SizedBox(width: 16),
              const Icon(Icons.work,
                  color: ColorsManager.secondaryColor, size: 16),
              const SizedBox(width: 4),
              const Text('3 years', style: TextStyle(color: Colors.black)),
            ],
          ),
        ],
      ),
      trailing: FilledButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            ColorsManager.primaryColor,
          ),
        ),
        onPressed: () async {
          var chatRoomId = getChatRoomIdByUsername(doctor.id, patient.id);
          Map<String, dynamic> chatRoomInfoMap = {
            "users": [doctor.id, patient.id]
          };
          await chatRepository.createChatRoom(chatRoomId, chatRoomInfoMap);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatRoomPatient(
                      therapist: doctor,
                      patient: patient,
                      chatRoomId: chatRoomId)));
        },
        child: const Text('Talk to Doctor'),
      ),
    );
  }
}
