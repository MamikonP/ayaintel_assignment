import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../l10n/l10n.dart';

class Validator {
  const Validator.of(this._context);

  final BuildContext _context;

  String? validateFirstName(String? value) {
    return value == null || value.isEmpty
        ? L10n.of(_context).tr.errorFieldRequired
        : value.trim().isEmpty
            ? L10n.of(_context).tr.errorInvalidFirstName
            : null;
  }

  String? validateSurname(String? value) {
    return value == null || value.isEmpty
        ? L10n.of(_context).tr.errorFieldRequired
        : value.trim().isEmpty
            ? L10n.of(_context).tr.errorInvalidSurname
            : null;
  }

  String? validateEmail(String? value) {
    final String? valid = value == null || value.isEmpty
        ? L10n.of(_context).tr.errorFieldRequired
        : null;
    if (valid != null) {
      return valid;
    }
    if (!EmailValidator.validate(value ?? '')) {
      return L10n.of(_context).tr.errorInvalidEmail;
    }
    return null;
  }

  String? validatePhoneNumber(PhoneNumber? phoneNumber) {
    if (phoneNumber?.isValid() == false) {
      return L10n.of(_context).tr.errorInvalidPhoneNumber;
    }
    return null;
  }

  String? validatePassword(String? value) {
    return value == null || value.isEmpty
        ? L10n.of(_context).tr.errorFieldRequired
        : value.trim().length < 6
            ? L10n.of(_context).tr.errorInvalidPassword
            : null;
  }

  String? validateConfirmPassword(String? value, String password) {
    return validatePassword(value) ?? (value == password
            ? null
            : L10n.of(_context).tr.errorPasswordDontMatch);
  }

  String? validateEmptyField(String? value) => value == null || value.isEmpty
      ? L10n.of(_context).tr.errorFieldRequired
      : null;
}
