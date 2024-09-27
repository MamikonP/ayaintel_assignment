import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/app_theme.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/user/user_bloc.dart';
import '../../shared/snackbars.dart';
import '../../widgets.dart';

class SignInScreen extends StatelessWidget with AuthenticationMixin {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthFailed && state.error != null) {
            CustomSnackbar.of(context).showErrorSnackBar(state.error!);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                CustomAppBar(
                  onLargeScaleDevice: constraints.maxWidth > 432,
                ),
                BlocListener<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserFailed && state.error != null) {
                      CustomSnackbar.of(context)
                          .showErrorSnackBar(state.error!);
                    } else if (state is UserLoaded) {
                      CustomSnackbar.of(context).showSuccessSnackBar(
                          'Logged in as ${state.userEntity?.firstname}\n${state.userEntity?.id}');
                    }
                  },
                  child: BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthFailed && state.error != null) {
                        CustomSnackbar.of(context)
                            .showErrorSnackBar(state.error!);
                      } else if (state is AuthLoaded) {
                        context.read<UserBloc>().add(
                              GetUserEvent(userId: state.userId ?? ''),
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
                                  child: const SignInContent(
                                      onLargeScaleDevice: true),
                                ),
                              ),
                            )
                          : const SignInContent(),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
