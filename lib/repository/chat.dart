import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xid/xid.dart';

class ChatRepository {
  final chatCollection = FirebaseFirestore.instance.collection("ChatRooms");
  final therapistCollection =
      FirebaseFirestore.instance.collection("Therapist");
  final patientCollection = FirebaseFirestore.instance.collection("Patient");

  createChatRoom(
      String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    final snapshot = await chatCollection.doc(chatRoomId).get();
    if (snapshot.exists) {
      return true;
    } else {
      return chatCollection.doc(chatRoomId).set(chatRoomInfoMap);
    }
  }

  sendMessage(
      String chatRoomId, Map<String, dynamic> messageInfoMap, String toUserId) {
    String messageId = Xid().toString();
    try {
      return chatCollection
          .doc(chatRoomId)
          .collection("chats")
          .doc(messageId)
          .set(messageInfoMap);
    } catch (e) {
      print(e.toString());
    }
  }

  updateLastMessageSent(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) {
    return chatCollection.doc(chatRoomId).update(lastMessageInfoMap);
  }

  Future<Stream<QuerySnapshot>> getChatMessages(chatRoomId) async {
    return chatCollection
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("sentDate", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms() async {
    String? myId = FirebaseAuth.instance.currentUser!.uid;
    return chatCollection
        .orderBy("dateSent", descending: true)
        .where("users", arrayContains: myId)
        .snapshots();
  }
}
