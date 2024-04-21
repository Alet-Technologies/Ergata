part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoading extends AuthenticationState {}

final class UnAuthenticated extends AuthenticationState {}

final class AuthenticationOtpSent extends AuthenticationState {}

final class AuthenticationSuccessPatient extends AuthenticationState {
  final MyPatient patient;

  const AuthenticationSuccessPatient(this.patient);

  @override
  List<Object> get props => [patient];
}

final class AuthenticationSuccessTherapist extends AuthenticationState {
  final MyPatient therapist;

  const AuthenticationSuccessTherapist(this.therapist);

  @override
  List<Object> get props => [therapist];
}

final class AuthenticationFailed extends AuthenticationState {
  final String errorMesssage;

  const AuthenticationFailed(this.errorMesssage);
}
