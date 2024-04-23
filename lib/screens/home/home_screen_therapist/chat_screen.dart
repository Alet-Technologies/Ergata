import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ergata/constants/colors.dart';
import 'package:ergata/models/patient_model.dart';
import 'package:ergata/models/therapist_model.dart';
import 'package:ergata/repository/authentication.dart';
import 'package:ergata/repository/chat.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatScreenTherapist extends StatefulWidget {
  const ChatScreenTherapist({super.key, required this.therapist});

  final MyTherapist therapist;

  @override
  State<ChatScreenTherapist> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreenTherapist> {
  final ChatRepository chatRepository = ChatRepository();
  final AuthRepository authRepository = AuthRepository();

  Stream? chatRoomStream;

  ontheload() async {
    chatRoomStream = await chatRepository.getChatRooms();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          StreamBuilder(
              stream: chatRoomStream,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<DocumentSnapshot> docs = snapshot.data!.docs;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = docs[index];
                      return ChatroomTile(
                          chatRoomId: ds.id,
                          dateSent: ds["dateSent"],
                          lastMessage: ds['lastMessage'],
                          patient: MyPatient.empty);
                    },
                    itemCount: snapshot.data.docs.length,
                    shrinkWrap: true,
                  );
                } else {
                  return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                    color: ColorsManager.primaryColor,
                    size: 50,
                  ));
                }
              }),
        ],
      ),
    );
  }
}

class ChatroomTile extends StatefulWidget {
  final String lastMessage, chatRoomId;
  final MyPatient patient;
  final Timestamp dateSent;
  const ChatroomTile(
      {super.key,
      required this.dateSent,
      required this.chatRoomId,
      required this.lastMessage,
      required this.patient});

  @override
  State<ChatroomTile> createState() => _ChatroomTileState();
}

class _ChatroomTileState extends State<ChatroomTile> {
  final AuthRepository authRepository = AuthRepository();

  MyPatient chatOponent = MyPatient.empty;
  String username = "";

  getthisuserInfo() async {
    String opId =
        widget.chatRoomId.replaceAll("_", "").replaceAll(widget.patient.id, "");
    MyPatient chatUser = await authRepository.getPatient(opId);
    setState(() {
      chatOponent = chatUser;
    });
  }

  @override
  void initState() {
    getthisuserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthRepository authRepository = AuthRepository();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.pinkAccent.shade100,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.grey[850],
        ),
        onPressed: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.all(2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/profile.png',
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        )),
                    chatOponent.id != ""
                        ? StreamBuilder(
                            stream: authRepository.patientsCollection
                                .doc(chatOponent.id)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                return Positioned(
                                  top: 38,
                                  left: 38,
                                  child: Icon(
                                    Icons.circle,
                                    color: snapshot.data!['isOnline'] == true
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                );
                              } else {
                                return const Positioned(
                                  top: 38,
                                  left: 38,
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.amber,
                                  ),
                                );
                              }
                            })
                        : const Positioned(
                            top: 38,
                            left: 38,
                            child: Icon(
                              Icons.circle,
                              color: Colors.transparent,
                            ),
                          )
                  ]),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Patient",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.lastMessage.length < 10
                            ? widget.lastMessage
                            : "${widget.lastMessage.substring(0, 10)}...",
                        style: TextStyle(
                            fontSize: 17,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w200,
                            color: Colors.grey.shade100),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                timeago.format(widget.dateSent.toDate()),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade400,
                    fontSize: 13),
              )
            ],
          ),
        ),
      ),
    );
  }
}
