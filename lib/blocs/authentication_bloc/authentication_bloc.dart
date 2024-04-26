// ignore_for_file: unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:ergata/models/patient_model.dart';
import 'package:ergata/models/therapist_model.dart';
import 'package:ergata/repository/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  final patientsCollection = FirebaseFirestore.instance.collection("Patients");
  final therapistCollection =
      FirebaseFirestore.instance.collection("Therapists");

  AuthenticationBloc({required this.authRepository})
      : super(AuthenticationInitial()) {
    on<CheckAuth>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        final isSignedIn = FirebaseAuth.instance.currentUser;
        if (isSignedIn != null) {
          final patientFound =
              await patientsCollection.doc(isSignedIn.uid).get();
          final therapistFound =
              await therapistCollection.doc(isSignedIn.uid).get();
          if (patientFound.exists) {
            MyPatient patient = await authRepository.getPatient(isSignedIn.uid);
            emit(AuthenticationSuccessPatient(patient));
          } else if (therapistFound.exists) {
            MyTherapist therapist =
                await authRepository.getTherapist(isSignedIn.uid);
            emit(AuthenticationSuccessTherapist(therapist));
          }
        } else {
          emit(UnAuthenticated());
        }
      } catch (e) {
        emit(AuthenticationFailed(e.toString()));
      }
    });

    on<SendOTPTherapist>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        await authRepository.sendOtp(
            phone: event.phone,
            errorStep: event.errorStep,
            nextStep: event.nextStep);
        emit(AuthenticationOtpSent());
      } catch (e) {
        emit(AuthenticationFailed(e.toString()));
      }
    });

    on<SendOTPPatient>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        await authRepository.sendOtp(
            phone: event.phone,
            errorStep: event.errorStep,
            nextStep: event.nextStep);
        emit(AuthenticationOtpSent());
      } catch (e) {
        emit(AuthenticationFailed(e.toString()));
      }
    });

    on<SignInPatient>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        final MyPatient patient = await authRepository.patientLoginWithOtp(
            otp: event.otp, phone: event.phone);
        emit(AuthenticationSuccessPatient(patient));
      } catch (e) {
        emit(AuthenticationFailed(e.toString()));
      }
    });

    on<SignInTherapy>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        final MyTherapist therapist = await authRepository
            .therapistLoginWithOtp(otp: event.otp, phone: event.phone);
        emit(AuthenticationSuccessTherapist(therapist));
      } catch (e) {
        emit(AuthenticationFailed(e.toString()));
      }
    });

    on<SignOut>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        await authRepository.logOut();
        emit(UnAuthenticated());
      } catch (e) {
        emit(AuthenticationFailed(e.toString()));
      }
    });
  }
}
