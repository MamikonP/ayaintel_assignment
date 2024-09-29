import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignInWithEmailPasswordEvent>(_mapSignInWithEmailPasswordEventToState);
    on<SignUpWithEmailPasswordEvent>(_mapSignUpWithEmailPasswordEventToState);
    on<ResetPasswordEvent>(_mapResetPasswordEventToState);
  }

  final AuthRepository authRepository;

  FutureOr<void> _mapSignInWithEmailPasswordEventToState(
      SignInWithEmailPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final userId = await authRepository.signInWithEmailPassword(
          event.email, event.password);
      emit(AuthLoaded(userId));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailed(e.message ?? ''));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  FutureOr<void> _mapSignUpWithEmailPasswordEventToState(
      SignUpWithEmailPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final userId = await authRepository.signUpWithEmailPassword(
          event.email, event.password);
      emit(AuthLoaded(userId));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailed(e.message ?? ''));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  FutureOr<void> _mapResetPasswordEventToState(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.resetPassword(event.email);
      emit(PasswordResetLinkSent());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailed(e.message ?? ''));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
