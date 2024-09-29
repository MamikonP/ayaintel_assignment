import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.userRepository, required this.authRepository})
      : super(UserInitial()) {
    on<SaveUserEvent>(_mapSaveUserEventToState);
    on<GetUserEvent>(_mapGetUserEventToState);
    on<GetLoggedInUserEvent>(_mapGetLoggedInUserEventToState);
  }

  final UserRepository userRepository;
  final AuthRepository authRepository;

  FutureOr<void> _mapSaveUserEventToState(
      SaveUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading(state));
    try {
      await userRepository.saveUser(event.entity);
      emit(UserLoaded(event.entity));
    } catch (e) {
      emit(UserFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapGetUserEventToState(
      GetUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading(state));
    try {
      final userEntity = await userRepository.getUser(event.userId);
      emit(UserLoaded(userEntity));
    } catch (e) {
      emit(UserFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapGetLoggedInUserEventToState(
      GetLoggedInUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading(state));
    try {
      final userEntity = await authRepository.getLoggedInUser();
      emit(UserLoggedIn(userEntity));
    } catch (e) {
      emit(UserFailed(state, e.toString()));
    }
  }
}
