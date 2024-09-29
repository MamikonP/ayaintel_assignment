part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState({this.userId, this.error});

  final String? userId;
  final String? error;

  @override
  List<Object?> get props => [userId, error];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoaded extends AuthState {
  const AuthLoaded(String userId) : super(userId: userId);
}

final class PasswordResetLinkSent extends AuthState {}

final class AuthFailed extends AuthState {
  const AuthFailed(String error) : super(error: error);
}
