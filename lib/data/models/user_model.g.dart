// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      email: json['email'] as String?,
      phonePrefix: json['phonePrefix'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      region: json['region'] as String?,
      city: json['city'] as String?,
      school: json['school'] as String?,
      subjects: (json['subjects'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      grades: (json['grades'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'phonePrefix': instance.phonePrefix,
      'phoneNumber': instance.phoneNumber,
      'region': instance.region,
      'city': instance.city,
      'school': instance.school,
      'subjects': instance.subjects,
      'grades': instance.grades,
    };
