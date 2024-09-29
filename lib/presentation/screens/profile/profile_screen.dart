import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/themes/app_theme.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/user/user_bloc.dart';
import '../../shared/snackbars.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserBloc>().state.userEntity;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailed && state.error != null) {
          CustomSnackbar.of(context).showErrorSnackBar(state.error!);
        } else if (state is LoggedOut) {
          Navigator.pushReplacementNamed(
            context,
            kSignInRoute,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${user?.firstname ?? ''} ${user?.lastname ?? ''}',
            style: AppTheme.currentThemeOf(context).bodyText1.copyWith(
                color: AppTheme.currentThemeOf(context).colorScheme.onPrimary),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutEvent());
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: kProfileImageRadius,
                child:
                    Text(user?.firstname?.substring(0, 1).toUpperCase() ?? ''),
              ),
              Column(
                children: [
                  Text(
                    user?.email ?? '',
                    style: AppTheme.currentThemeOf(context).bodyText1,
                  ),
                  kSmall.v,
                  Text(
                    user?.phoneNumber ?? '',
                    style: AppTheme.currentThemeOf(context).bodyText1,
                  ),
                  kSmall.v,
                  Text(
                    user?.region ?? '',
                    style: AppTheme.currentThemeOf(context).bodyText1,
                  ),
                  kSmall.v,
                  Text(
                    user?.city ?? '',
                    style: AppTheme.currentThemeOf(context).bodyText1,
                  ),
                  kSmall.v,
                  Text(
                    user?.school ?? '',
                    style: AppTheme.currentThemeOf(context).bodyText1,
                  ),
                  kSmall.v,
                  Text(
                    user?.subjects
                            ?.map(
                              (e) => e,
                            )
                            .toList()
                            .join(', ') ??
                        '',
                    style: AppTheme.currentThemeOf(context).bodyText1,
                  ),
                  kSmall.v,
                  Text(
                    user?.grades
                            ?.map(
                              (e) => e,
                            )
                            .toList()
                            .join(', ') ??
                        '',
                    style: AppTheme.currentThemeOf(context).bodyText1,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
