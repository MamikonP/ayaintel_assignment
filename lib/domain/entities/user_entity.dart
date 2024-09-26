import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'user_entity.g.dart';

@CopyWith()
class UserEntity extends Equatable {
  const UserEntity({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.phonePrefix,
    this.phoneNumber,
    this.region,
    this.city,
    this.school,
    this.subjects,
    this.grades,
  });

  final String? id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phonePrefix;
  final String? phoneNumber;
  final String? region;
  final String? city;
  final String? school;
  final List<String>? subjects;
  final List<int>? grades;

  @override
  List<Object?> get props => [
        id,
        firstname,
        lastname,
        email,
        phonePrefix,
        phoneNumber,
        region,
        city,
        school,
        subjects,
        grades,
      ];
}
