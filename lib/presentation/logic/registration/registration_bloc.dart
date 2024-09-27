import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<UpdateFirstNameEvent>(_mapUpdateFirstNameEventToState);
    on<UpdateLastNameEvent>(_mapUpdateLastNameEventToState);
    on<UpdateEmailEvent>(_mapUpdateEmailEventToState);
    on<UpdatePhoneNumberEvent>(_mapUpdatePhoneNumberEventToState);
    on<UpdateRegionEvent>(_mapUpdateRegionEventToState);
    on<UpdateCityEvent>(_mapUpdateCityEventToState);
    on<UpdateSchoolEvent>(_mapUpdateSchoolEventToState);
    on<UpdateSubjectEvent>(_mapUpdateSubjectEventToState);
    on<UpdateGradeEvent>(_mapUpdateGradeEventToState);
    on<UpdatePasswordEvent>(_mapUpdatePasswordEventToState);
  }

  FutureOr<void> _mapUpdateFirstNameEventToState(
      UpdateFirstNameEvent event, Emitter<RegistrationState> emit) {
    emit(RegistrationUpdated(state, name: event.name));
  }

  FutureOr<void> _mapUpdateLastNameEventToState(
      UpdateLastNameEvent event, Emitter<RegistrationState> emit) {
    emit(RegistrationUpdated(state, surname: event.surname));
  }

  FutureOr<void> _mapUpdateEmailEventToState(
      UpdateEmailEvent event, Emitter<RegistrationState> emit) {
    emit(RegistrationUpdated(state, email: event.email));
  }

  FutureOr<void> _mapUpdatePhoneNumberEventToState(
      UpdatePhoneNumberEvent event, Emitter<RegistrationState> emit) {
    emit(RegistrationUpdated(state,
        phoneNumber: event.phoneNumber, phonePrefix: event.phonePrefix));
  }

  FutureOr<void> _mapUpdateRegionEventToState(
      UpdateRegionEvent event, Emitter<RegistrationState> emit) {
    emit(RegistrationUpdated(state, region: event.region));
  }

  FutureOr<void> _mapUpdateCityEventToState(
      UpdateCityEvent event, Emitter<RegistrationState> emit) {
    emit(RegistrationUpdated(state, city: event.city));
  }

  FutureOr<void> _mapUpdateSchoolEventToState(
      UpdateSchoolEvent event, Emitter<RegistrationState> emit) {
    emit(RegistrationUpdated(state, school: event.school));
  }

  FutureOr<void> _mapUpdateSubjectEventToState(
      UpdateSubjectEvent event, Emitter<RegistrationState> emit) {
    emit(RegistrationUpdated(state, subjects: event.subjects));
  }

  FutureOr<void> _mapUpdateGradeEventToState(
      UpdateGradeEvent event, Emitter<RegistrationState> emit) {
    emit(RegistrationUpdated(state, grades: event.grades));
  }

  FutureOr<void> _mapUpdatePasswordEventToState(
      UpdatePasswordEvent event, Emitter<RegistrationState> emit) {
    emit(RegistrationUpdated(state, confirmPassword: event.password));
  }
}
