import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enums/sign_up_type.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/registration/registration_bloc.dart';
import '../../screens.dart';

class SignUpRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin<T> {
  SignUpRoute({super.settings, this.maintainState = true})
      : super(fullscreenDialog: false);

  @override
  Widget buildContent(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: RepositoryProvider.of(context),
          ),
        ),
        BlocProvider<RegistrationBloc>(
          create: (context) => RegistrationBloc(),
        ),
      ],
      child: SignUpScreen(
        signUpType: settings.arguments as SignUpType? ?? SignUpType.teacher,
      ),
    );
  }

  @override
  final bool maintainState;
}
