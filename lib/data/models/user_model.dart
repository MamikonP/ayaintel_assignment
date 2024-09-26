import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    super.id,
    super.firstname,
    super.lastname,
    super.email,
    super.phonePrefix,
    super.phoneNumber,
    super.region,
    super.city,
    super.school,
    super.subjects,
    super.grades,
  });

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
        id: entity.id,
        firstname: entity.firstname,
        lastname: entity.lastname,
        email: entity.email,
        phonePrefix: entity.phonePrefix,
        phoneNumber: entity.phoneNumber,
        region: entity.region,
        city: entity.city,
        school: entity.school,
        subjects: entity.subjects,
        grades: entity.grades,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserEntity toEntity() => UserEntity(
        id: id,
        firstname: firstname,
        lastname: lastname,
        email: email,
        phonePrefix: phonePrefix,
        phoneNumber: phoneNumber,
        region: region,
        city: city,
        school: school,
        subjects: subjects,
        grades: grades,
      );
}
