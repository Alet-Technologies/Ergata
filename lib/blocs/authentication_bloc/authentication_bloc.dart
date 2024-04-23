// ignore_for_file: unused_local_variable

import 'package:bloc/bloc.dart';
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

  AuthenticationBloc({required this.authRepository})
      : super(AuthenticationInitial()) {
    on<CheckAuth>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        final isSignedIn = FirebaseAuth.instance.currentUser;
        if (isSignedIn != null) {
          MyPatient patient = await authRepository.getPatient(isSignedIn.uid);
          emit(AuthenticationSuccessPatient(patient));
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
        final MyPatient patient = await authRepository.therapistLoginWithOtp(
            otp: event.otp, phone: event.phone);
        emit(AuthenticationSuccessPatient(patient));
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
