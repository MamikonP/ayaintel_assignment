import 'package:flutter/material.dart';

import '../../core/themes/app_theme.dart';

class CustomSnackbar {
  CustomSnackbar._();

  factory CustomSnackbar.of(BuildContext context) =>
      _instance.._context = context;

  late final BuildContext _context;

  static CustomSnackbar get _instance => CustomSnackbar._();

  void showErrorSnackBar(String error) =>
      ScaffoldMessenger.of(_context).showSnackBar(SnackBar(
        content: Text(error),
        backgroundColor: AppTheme.currentThemeOf(_context).error,
      ));

  void showSuccessSnackBar(String message) =>
      ScaffoldMessenger.of(_context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.currentThemeOf(_context).primary,
      ));
}
