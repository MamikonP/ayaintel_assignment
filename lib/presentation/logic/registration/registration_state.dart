part of 'registration_bloc.dart';

sealed class RegistrationState extends Equatable {
  const RegistrationState({
    this.name,
    this.surname,
    this.email,
    this.phoneNumber,
    this.phonePrefix,
    this.region,
    this.city,
    this.school,
    this.subjects,
    this.grades,
    this.password,
    this.confirmPassword,
  });

  final String? name;
  final String? surname;
  final String? email;
  final String? phoneNumber;
  final String? phonePrefix;
  final String? region;
  final String? city;
  final String? school;
  final List<String>? subjects;
  final List<String>? grades;
  final String? password;
  final String? confirmPassword;

  @override
  List<Object?> get props => [
        name,
        surname,
        email,
        phoneNumber,
        phonePrefix,
        region,
        city,
        school,
        subjects,
        grades,
        password,
        confirmPassword,
      ];
}

final class RegistrationInitial extends RegistrationState {}

final class RegistrationUpdated extends RegistrationState {
  RegistrationUpdated(
    RegistrationState initState, {
    String? name,
    String? surname,
    String? email,
    String? phoneNumber,
    String? phonePrefix,
    String? region,
    String? city,
    String? school,
    List<String>? subjects,
    List<String>? grades,
    String? password,
    String? confirmPassword,
  }) : super(
          name: name ?? initState.name,
          surname: surname ?? initState.surname,
          email: email ?? initState.email,
          phoneNumber: phoneNumber ?? initState.phoneNumber,
          phonePrefix: phonePrefix ?? initState.phonePrefix,
          region: region ?? initState.region,
          city: city ?? initState.city,
          school: school ?? initState.school,
          subjects: subjects ?? initState.subjects,
          grades: grades ?? initState.grades,
          password: password ?? initState.password,
          confirmPassword: confirmPassword ?? initState.confirmPassword,
        );
}
