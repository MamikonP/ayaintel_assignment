import 'package:flutter/material.dart';

class CustomSnackbar {
  CustomSnackbar._();

  factory CustomSnackbar.of(BuildContext context) =>
      _instance.._context = context;

  late final BuildContext _context;

  static CustomSnackbar get _instance => CustomSnackbar._();

  void showErrorSnackBar(String error) => ScaffoldMessenger.of(_context)
      .showSnackBar(SnackBar(content: Text(error)));
}
