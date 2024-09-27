// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserEntityCWProxy {
  UserEntity id(String? id);

  UserEntity firstname(String? firstname);

  UserEntity lastname(String? lastname);

  UserEntity email(String? email);

  UserEntity phonePrefix(String? phonePrefix);

  UserEntity phoneNumber(String? phoneNumber);

  UserEntity region(String? region);

  UserEntity city(String? city);

  UserEntity school(String? school);

  UserEntity subjects(List<String>? subjects);

  UserEntity grades(List<String>? grades);

  UserEntity signUpType(SignUpType signUpType);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  UserEntity call({
    String? id,
    String? firstname,
    String? lastname,
    String? email,
    String? phonePrefix,
    String? phoneNumber,
    String? region,
    String? city,
    String? school,
    List<String>? subjects,
    List<String>? grades,
    SignUpType? signUpType,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserEntity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserEntity.copyWith.fieldName(...)`
class _$UserEntityCWProxyImpl implements _$UserEntityCWProxy {
  const _$UserEntityCWProxyImpl(this._value);

  final UserEntity _value;

  @override
  UserEntity id(String? id) => this(id: id);

  @override
  UserEntity firstname(String? firstname) => this(firstname: firstname);

  @override
  UserEntity lastname(String? lastname) => this(lastname: lastname);

  @override
  UserEntity email(String? email) => this(email: email);

  @override
  UserEntity phonePrefix(String? phonePrefix) => this(phonePrefix: phonePrefix);

  @override
  UserEntity phoneNumber(String? phoneNumber) => this(phoneNumber: phoneNumber);

  @override
  UserEntity region(String? region) => this(region: region);

  @override
  UserEntity city(String? city) => this(city: city);

  @override
  UserEntity school(String? school) => this(school: school);

  @override
  UserEntity subjects(List<String>? subjects) => this(subjects: subjects);

  @override
  UserEntity grades(List<String>? grades) => this(grades: grades);

  @override
  UserEntity signUpType(SignUpType signUpType) => this(signUpType: signUpType);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  UserEntity call({
    Object? id = const $CopyWithPlaceholder(),
    Object? firstname = const $CopyWithPlaceholder(),
    Object? lastname = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? phonePrefix = const $CopyWithPlaceholder(),
    Object? phoneNumber = const $CopyWithPlaceholder(),
    Object? region = const $CopyWithPlaceholder(),
    Object? city = const $CopyWithPlaceholder(),
    Object? school = const $CopyWithPlaceholder(),
    Object? subjects = const $CopyWithPlaceholder(),
    Object? grades = const $CopyWithPlaceholder(),
    Object? signUpType = const $CopyWithPlaceholder(),
  }) {
    return UserEntity(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      firstname: firstname == const $CopyWithPlaceholder()
          ? _value.firstname
          // ignore: cast_nullable_to_non_nullable
          : firstname as String?,
      lastname: lastname == const $CopyWithPlaceholder()
          ? _value.lastname
          // ignore: cast_nullable_to_non_nullable
          : lastname as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      phonePrefix: phonePrefix == const $CopyWithPlaceholder()
          ? _value.phonePrefix
          // ignore: cast_nullable_to_non_nullable
          : phonePrefix as String?,
      phoneNumber: phoneNumber == const $CopyWithPlaceholder()
          ? _value.phoneNumber
          // ignore: cast_nullable_to_non_nullable
          : phoneNumber as String?,
      region: region == const $CopyWithPlaceholder()
          ? _value.region
          // ignore: cast_nullable_to_non_nullable
          : region as String?,
      city: city == const $CopyWithPlaceholder()
          ? _value.city
          // ignore: cast_nullable_to_non_nullable
          : city as String?,
      school: school == const $CopyWithPlaceholder()
          ? _value.school
          // ignore: cast_nullable_to_non_nullable
          : school as String?,
      subjects: subjects == const $CopyWithPlaceholder()
          ? _value.subjects
          // ignore: cast_nullable_to_non_nullable
          : subjects as List<String>?,
      grades: grades == const $CopyWithPlaceholder()
          ? _value.grades
          // ignore: cast_nullable_to_non_nullable
          : grades as List<String>?,
      signUpType:
          signUpType == const $CopyWithPlaceholder() || signUpType == null
              ? _value.signUpType
              // ignore: cast_nullable_to_non_nullable
              : signUpType as SignUpType,
    );
  }
}

extension $UserEntityCopyWith on UserEntity {
  /// Returns a callable class that can be used as follows: `instanceOfUserEntity.copyWith(...)` or like so:`instanceOfUserEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserEntityCWProxy get copyWith => _$UserEntityCWProxyImpl(this);
}
