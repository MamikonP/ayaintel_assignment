// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

import '../../presentation/routes.dart';
import '../constants.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings,
      {dynamic arguments}) {
    switch (settings.name) {
      case kSignInRoute:
        return SignInRoute<dynamic>(settings: settings);
      case kSignUpRoute:
        return SignUpRoute<dynamic>(settings: settings);
      default:
        throw Exception('Route not found!');
    }
  }
}
