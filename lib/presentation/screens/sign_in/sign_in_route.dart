import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/user/user_bloc.dart';
import '../../screens.dart';

class SignInRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin<T> {
  SignInRoute({super.settings, this.maintainState = true})
      : super(fullscreenDialog: false);

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        authRepository: RepositoryProvider.of(context),
      ),
      child: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoggedIn && state.userEntity != null) {
            Navigator.pushReplacementNamed(context, kProfileRoute);
          }
        },
        builder: (context, state) {
          if (state is UserLoggedIn && state.userEntity != null) {
            return const SizedBox.shrink();
          }
          return const SignInScreen();
        },
      ),
    );
  }

  @override
  final bool maintainState;
}
