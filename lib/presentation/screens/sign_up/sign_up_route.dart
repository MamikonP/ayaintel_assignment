import 'package:flutter/material.dart';

import '../../screens.dart';

class SignUpRoute<T> extends PageRoute<T>
    with MaterialRouteTransitionMixin<T> {
  SignUpRoute({super.settings, this.maintainState = true})
      : super(fullscreenDialog: false);

  @override
  Widget buildContent(BuildContext context) {
    return const SignUpScreen();
  }

  @override
  final bool maintainState;
}
