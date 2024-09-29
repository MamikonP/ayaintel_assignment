import 'package:flutter/material.dart';

mixin AuthControllerMixin {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final regionController = TextEditingController();
  final cityController = TextEditingController();
  final schoolController = TextEditingController();
  final subjectController = TextEditingController();
  final gradeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final nameFormKey = GlobalKey<FormFieldState<dynamic>>();
  final surnameFormKey = GlobalKey<FormFieldState<dynamic>>();
  final emailFormKey = GlobalKey<FormFieldState<dynamic>>();
  final passwordFormKey = GlobalKey<FormFieldState<dynamic>>();
  final confirmPasswordFormKey = GlobalKey<FormFieldState<dynamic>>();
}
