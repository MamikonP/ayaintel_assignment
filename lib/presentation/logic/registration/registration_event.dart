part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class UpdateFirstNameEvent extends RegistrationEvent {
  const UpdateFirstNameEvent(this.name);

  final String? name;
}

class UpdateLastNameEvent extends RegistrationEvent {
  const UpdateLastNameEvent(this.surname);

  final String? surname;
}

class UpdateEmailEvent extends RegistrationEvent {
  const UpdateEmailEvent(this.email);

  final String? email;
}

class UpdatePhoneNumberEvent extends RegistrationEvent {
  const UpdatePhoneNumberEvent(this.phoneNumber, this.phonePrefix);

  final String? phoneNumber;
  final String? phonePrefix;
}

class UpdateRegionEvent extends RegistrationEvent {
  const UpdateRegionEvent(this.region);

  final String? region;
}

class UpdateCityEvent extends RegistrationEvent {
  const UpdateCityEvent(this.city);

  final String? city;
}

class UpdateSchoolEvent extends RegistrationEvent {
  const UpdateSchoolEvent(this.school);

  final String? school;
}

class UpdateSubjectEvent extends RegistrationEvent {
  const UpdateSubjectEvent(this.subjects);

  final List<String>? subjects;
}

class UpdateGradeEvent extends RegistrationEvent {
  const UpdateGradeEvent(this.grades);

  final List<String>? grades;
}

class UpdatePasswordEvent extends RegistrationEvent {
  const UpdatePasswordEvent(this.password);

  final String? password;
}

class UpdateConfirmPasswordEvent extends RegistrationEvent {
  const UpdateConfirmPasswordEvent(this.password);

  final String? password;
}
