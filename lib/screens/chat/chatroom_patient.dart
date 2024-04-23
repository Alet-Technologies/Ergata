import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ergata/constants/colors.dart';
import 'package:ergata/models/patient_model.dart';
import 'package:ergata/models/therapist_model.dart';
import 'package:ergata/repository/chat.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatRoomPatient extends StatefulWidget {
  const ChatRoomPatient(
      {super.key,
      required this.therapist,
      required this.chatRoomId,
      required this.patient});

  final MyTherapist therapist;
  final MyPatient patient;
  final String chatRoomId;

  @override
  State<ChatRoomPatient> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoomPatient> {
  final TextEditingController _messageController = TextEditingController();
  final ChatRepository chatRepository = ChatRepository();

  Stream? messageStream;

  Future addMessage(String text) async {
    if (_messageController.text != "") {
      Map<String, dynamic> messageInfoMap = {
        "message": text,
        "sentBy": widget.patient.id,
        "sentDate": Timestamp.now()
      };

      chatRepository
          .sendMessage(widget.chatRoomId, messageInfoMap, widget.therapist.id)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": text,
          "dateSent": DateTime.now(),
          "sentBy": widget.patient.id
        };
        chatRepository.updateLastMessageSent(
            widget.chatRoomId, lastMessageInfoMap);
      });
    }
  }

  Widget chatMessage() {
    return StreamBuilder(
        stream: messageStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return chatMessageTile(
                        ds["message"], widget.patient.id == ds['sentBy']);
                  })
              : Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                  color: ColorsManager.primaryColor,
                  size: 50,
                ));
        });
  }

  getAndSetMessage() async {
    messageStream = await chatRepository.getChatMessages(widget.chatRoomId);
    setState(() {});
  }

  ontheload() async {
    await getAndSetMessage();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Widget chatMessageTile(String message, bool sentByMe) {
    return Align(
        alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin:
              EdgeInsets.only(bottom: 10, right: sentByMe ? 10 : 0, left: 10),
          decoration: BoxDecoration(
            color: sentByMe
                ? ColorsManager.primaryColor
                : ColorsManager.secondaryColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              topRight: const Radius.circular(12),
              bottomLeft: sentByMe
                  ? const Radius.circular(12)
                  : const Radius.circular(0),
              bottomRight: sentByMe
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Dr. ${widget.therapist.fullName}"),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: ColorsManager.primaryColor,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: chatMessage(),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                  child: TextField(
                style: const TextStyle(color: ColorsManager.primaryColor),
                controller: _messageController,
                onSubmitted: (text) {
                  if (text != "" || text != " ") {
                    addMessage(text);
                    _messageController.clear();
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: ColorsManager.primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: ColorsManager.primaryColor),
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: ColorsManager.primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.emoji_emotions,
                          color: ColorsManager.primaryColor,
                        )),
                    focusColor: ColorsManager.primaryColor,
                    fillColor: Colors.grey.shade800,
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (_messageController.text != "" ||
                              _messageController.text != " ") {
                            addMessage(_messageController.text);
                            _messageController.clear();
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: ColorsManager.primaryColor,
                        )),
                    hintText: 'Type a message...',
                    hintStyle:
                        const TextStyle(color: ColorsManager.secondaryColor),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 4)),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
