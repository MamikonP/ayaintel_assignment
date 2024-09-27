import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/assets_text.dart';
import '../../../core/util/uuid_generator.dart';
import '../../../domain/entities/user_entity.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/registration/registration_bloc.dart';
import '../../logic/user/user_bloc.dart';
import '../../shared/snackbars.dart';
import '../../widgets.dart';

class SignUpScreen extends StatelessWidget with UuidGenerator {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: AssetImageWidget.svg(imageName: AssetsText.icNextGeneration),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          ),
          BlocBuilder<RegistrationBloc, RegistrationState>(
            builder: (context, registrationState) {
              return BlocListener<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserFailed && state.error != null) {
                    CustomSnackbar.of(context).showErrorSnackBar(state.error!);
                  } else if (state is UserLoaded) {
                    CustomSnackbar.of(context).showSuccessSnackBar('Done');
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
                                id: uuidV1,
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
                    child: SignUpContent(),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
