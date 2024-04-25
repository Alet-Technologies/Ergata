// ignore_for_file: use_build_context_synchronously

import 'package:ergata/constants/colors.dart';
import 'package:ergata/models/patient_model.dart';
import 'package:ergata/models/therapist_model.dart';
import 'package:ergata/repository/authentication.dart';
import 'package:ergata/repository/chat.dart';
import 'package:ergata/screens/chat/chatroom_patient.dart';
import 'package:ergata/service/utility.dart';
import 'package:flutter/material.dart';

class SearchScreenPatient extends StatefulWidget {
  const SearchScreenPatient({super.key, required this.patient});

  final MyPatient patient;

  @override
  State<SearchScreenPatient> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreenPatient> {
  final TextEditingController _searchController = TextEditingController();
  final AuthRepository authRepository = AuthRepository();
  final ChatRepository chatRepository = ChatRepository();
  late List<MyTherapist> therapists = [];

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  ontheload() async {
    therapists = [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Implement your search logic here
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ListView.builder(
                  itemCount: therapists.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        var chatRoomId = getChatRoomIdByUsername(
                            therapists[index].id, widget.patient.id);
                        Map<String, dynamic> chatRoomInfoMap = {
                          "users": [therapists[index].id, widget.patient.id]
                        };
                        await chatRepository.createChatRoom(
                            chatRoomId, chatRoomInfoMap);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatRoomPatient(
                                    therapist: therapists[index],
                                    patient: widget.patient,
                                    chatRoomId: chatRoomId)));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: ColorsManager.gray76,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ListTile(
                          title: Text(therapists[index].phone),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
