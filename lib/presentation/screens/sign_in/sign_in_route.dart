import 'package:flutter/material.dart';

import '../../screens.dart';

class SignInRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin<T> {
  SignInRoute({super.settings, this.maintainState = true})
      : super(fullscreenDialog: false);

  @override
  Widget buildContent(BuildContext context) {
    return const SignInScreen();
  }

  @override
  final bool maintainState;
}
