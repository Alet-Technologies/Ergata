import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ergata/entities/therapistentity.dart';

import '../models/therapist_model.dart';

class TherapistService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final therapistCollection =
      FirebaseFirestore.instance.collection("Therapists");

  Future<List<MyTherapist>> fetchAllTherapists() async {
    List<MyTherapist> allTherapists = [];
    try {
      await therapistCollection.get().then((value) {
        for (var doc in value.docs) {
          var therapist =
              MyTherapist.fromEntity(TherapistEntity.fromDocument(doc.data()));
          allTherapists.add(therapist);
        }
      });
    } catch (e) {
      rethrow;
    }
    return allTherapists;
  }

  Future<MyTherapist?> fetchTherapistById(String id) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('therapists').doc(id).get();
    if (snapshot.exists) {
      return MyTherapist.fromEntity(TherapistEntity.fromDocument(
          snapshot.data() as Map<String, dynamic>));
    } else {
      return null;
    }
  }
}
