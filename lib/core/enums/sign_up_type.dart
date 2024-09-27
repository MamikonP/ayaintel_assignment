enum SignUpType {
  donor,
  teacher;

  factory SignUpType.fromValue(String value) => SignUpType.values.firstWhere(
        (SignUpType element) => element.name == value.toLowerCase(),
        orElse: () => SignUpType.teacher,
      );
}
