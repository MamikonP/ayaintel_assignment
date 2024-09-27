import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/enums/sign_up_type.dart';
import '../../../core/themes/app_theme.dart';
import '../../../domain/entities/user_entity.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/registration/registration_bloc.dart';
import '../../logic/user/user_bloc.dart';
import '../../shared/snackbars.dart';
import '../../widgets.dart';

class SignUpScreen extends StatelessWidget with AuthenticationMixin {
  const SignUpScreen({super.key, required this.signUpType});

  final SignUpType signUpType;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomAppBar(
              onLargeScaleDevice: constraints.maxWidth > 432,
            ),
            BlocBuilder<RegistrationBloc, RegistrationState>(
              builder: (context, registrationState) {
                return BlocListener<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserFailed && state.error != null) {
                      CustomSnackbar.of(context)
                          .showErrorSnackBar(state.error!);
                    } else if (state is UserLoaded) {
                      CustomSnackbar.of(context).showSuccessSnackBar(
                          'Signed up as ${state.userEntity?.firstname}\n${state.userEntity?.id}');
                      Navigator.pushReplacementNamed(context, kSignInRoute);
                    }
                  },
                  child: BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthFailed && state.error != null) {
                        CustomSnackbar.of(context)
                            .showErrorSnackBar(state.error!);
                      } else if (state is AuthLoaded) {
                        context.read<UserBloc>().add(
                              SaveUserEvent(
                                entity: UserEntity(
                                  id: state.userId,
                                  firstname: registrationState.name,
                                  lastname: registrationState.surname,
                                  email: registrationState.email,
                                  phonePrefix: registrationState.phonePrefix,
                                  phoneNumber: registrationState.phoneNumber,
                                  city: registrationState.city,
                                  region: registrationState.region,
                                  school: registrationState.school,
                                  subjects: registrationState.subjects,
                                  grades: registrationState.grades,
                                ),
                              ),
                            );
                      }
                    },
                    child: SliverFillRemaining(
                      hasScrollBody: false,
                      child: kIsWeb && constraints.maxWidth > 432
                          ? Center(
                              child: ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 432),
                                child: Card(
                                  color: AppTheme.currentThemeOf(context)
                                      .background,
                                  child: SignUpContent(
                                    signUpType: signUpType,
                                    onLargeScaleDevice: true,
                                  ),
                                ),
                              ),
                            )
                          : SignUpContent(signUpType: signUpType),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
