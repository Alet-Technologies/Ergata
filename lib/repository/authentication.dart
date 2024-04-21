import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ergata/entities/patiententity.dart';
import 'package:ergata/entities/therapistentity.dart';
import 'package:ergata/models/therapist_model.dart';
import 'package:ergata/models/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final patientsCollection = FirebaseFirestore.instance.collection("Patients");
  final therapistCollection =
      FirebaseFirestore.instance.collection("Therapist");
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser;
      return user;
    });
  }

  static String verifyId = "";

  Future sendOtp(
      {required String phone,
      required Function errorStep,
      required Function nextStep}) async {
    await _firebaseAuth
        .verifyPhoneNumber(
      timeout: const Duration(seconds: 120),
      phoneNumber: "+251$phone",
      verificationCompleted: (phoneAuthCredential) async {
        return;
      },
      verificationFailed: (error) async {
        return;
      },
      codeSent: (verificationId, forceResendingToken) async {
        verifyId = verificationId;
        nextStep();
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        return;
      },
    )
        .onError((error, stackTrace) {
      errorStep();
    });
  }

  Future patientLoginWithOtp(
      {required String otp, required String phone}) async {
    final credential =
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);
    try {
      final user = await _firebaseAuth.signInWithCredential(credential);
      if (user.user != null) {
        final checkUserFound = patientsCollection.doc(user.user!.uid).get();
        if (checkUserFound == null) {
          return patientsCollection.doc(user.user!.uid).get().then((value) =>
              MyPatient.fromEntity(PatientEntity.fromDocument(value.data()!)));
        }
        MyPatient myUser = MyPatient(
            id: user.user!.uid,
            phone: phone,
            age: "",
            gender: "",
            isDiagnosed: false,
            diagnosedWith: "");
        await patientsCollection
            .doc(myUser.id)
            .set(myUser.toEntity().toDocument());
        return myUser;
      }
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future therapistLoginWithOtp(
      {required String otp, required String phone}) async {
    final credential =
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);
    try {
      final user = await _firebaseAuth.signInWithCredential(credential);
      if (user.user != null) {
        final checkUserFound = therapistCollection.doc(user.user!.uid).get();
        if (checkUserFound == null) {
          return therapistCollection.doc(user.user!.uid).get().then((value) =>
              MyTherapist.fromEntity(
                  TherapistEntity.fromDocument(value.data()!)));
        }
        MyTherapist myUser = MyTherapist(
            id: user.user!.uid,
            fullName: "",
            phone: phone,
            photo: "",
            category: "",
            description: "",
            license: "",
            price: 0,
            rating: 0,
            verified: false);
        await therapistCollection
            .doc(myUser.id)
            .set(myUser.toEntity().toDocument());
        return myUser;
      }
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<MyPatient> getPatient(String myPatientId) async {
    try {
      return patientsCollection.doc(myPatientId).get().then((value) =>
          MyPatient.fromEntity(PatientEntity.fromDocument(value.data()!)));
    } catch (e) {
      rethrow;
    }
  }

  Future<MyTherapist> getTherapist(String myTherapistId) async {
    try {
      return therapistCollection.doc(myTherapistId).get().then((value) =>
          MyTherapist.fromEntity(TherapistEntity.fromDocument(value.data()!)));
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MyTherapist>> getUsers() async {
    List<MyTherapist> allUsers = [];
    try {
      await patientsCollection.get().then((value) {
        for (var i in value.docs) {
          var user =
              MyTherapist.fromEntity(TherapistEntity.fromDocument(i.data()));
          allUsers.add(user);
        }
      });
    } catch (e) {
      rethrow;
    }
    return allUsers;
  }

  Future logOut() async {
    try {
      await _firebaseAuth.signOut();
      return "Logged Out!";
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> isLoggedIn() async {
    var user = _firebaseAuth.currentUser;
    return user != null;
  }
}
