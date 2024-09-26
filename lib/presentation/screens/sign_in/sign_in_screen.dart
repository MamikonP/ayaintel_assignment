import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/auth/auth_bloc.dart';
import '../../shared/snackbars.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthFailed && state.error != null) {
          CustomSnackbar.of(context).showErrorSnackBar(state.error!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(child: Text(state.userId ?? '')),
        );
      },
    );
  }
}
