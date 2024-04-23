part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class CheckAuth extends AuthenticationEvent {}

final class SendOTPTherapist extends AuthenticationEvent {
  final String phone;
  final Function errorStep;
  final Function nextStep;

  const SendOTPTherapist(this.phone, this.errorStep, this.nextStep);
}

final class SendOTPPatient extends AuthenticationEvent {
  final String phone;
  final Function errorStep;
  final Function nextStep;

  const SendOTPPatient(this.phone, this.errorStep, this.nextStep);
}

final class SignInPatient extends AuthenticationEvent {
  final String otp;
  final String phone;

  const SignInPatient(this.otp, this.phone);
}

final class SignInTherapy extends AuthenticationEvent {
  final String otp;
  final String phone;

  const SignInTherapy(this.otp, this.phone);
}

final class SignOut extends AuthenticationEvent {}
