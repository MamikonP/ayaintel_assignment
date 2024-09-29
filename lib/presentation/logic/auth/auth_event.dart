part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInWithEmailPasswordEvent extends AuthEvent {
  const SignInWithEmailPasswordEvent(
      {required this.email, required this.password});

  final String email;
  final String password;
}

class SignUpWithEmailPasswordEvent extends AuthEvent {
  const SignUpWithEmailPasswordEvent(
      {required this.email, required this.password});

  final String email;
  final String password;
}

class ResetPasswordEvent extends AuthEvent {
  const ResetPasswordEvent({required this.email});

  final String email;
}
