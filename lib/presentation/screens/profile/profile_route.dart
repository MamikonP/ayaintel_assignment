import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/auth/auth_bloc.dart';
import '../../screens.dart';

class ProfileRoute<T> extends PageRoute<T>
    with MaterialRouteTransitionMixin<T> {
  ProfileRoute({super.settings, this.maintainState = true})
      : super(fullscreenDialog: false);

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthBloc(authRepository: RepositoryProvider.of(context)),
      child: const ProfileScreen(),
    );
  }

  @override
  final bool maintainState;
}
