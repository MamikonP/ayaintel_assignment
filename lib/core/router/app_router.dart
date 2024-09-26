// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

import '../../presentation/routes.dart';
import '../constants.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings,
      {dynamic arguments}) {
    switch (settings.name) {
      case kSignInRoute:
        return SignInRoute<dynamic>();
      case kSignUpRoute:
        return SignUpRoute<dynamic>();
      default:
        throw Exception('Route not found!');
    }
  }
}
