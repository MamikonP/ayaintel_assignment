import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/enums/sign_up_type.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/themes/app_theme.dart';
import '../../../domain/entities/user_entity.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/registration/registration_bloc.dart';
import '../../logic/user/user_bloc.dart';
import '../../shared/snackbars.dart';
import '../../widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.signUpType});

  final SignUpType signUpType;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with AuthenticationMixin, SingleTickerProviderStateMixin, SliversMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: kTabBarSize, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        body: constraints.maxWidth > kMaxRequiredMobileSize
            ? NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) =>
                    sliverHeaderBuilder(
                  context,
                  onLargeScaleDevice:
                      constraints.maxWidth > kMaxRequiredMobileSize,
                  tabController: _tabController,
                ),
                body: WebTabBarContent(tabController: _tabController),
              )
            : SignUpBody(signUpType: widget.signUpType),
      ),
    );
  }
}

class SignUpBody extends StatelessWidget {
  const SignUpBody({
    super.key,
    required this.signUpType,
    this.onLargeScaleDevice = false,
  });

  final SignUpType signUpType;
  final bool onLargeScaleDevice;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        if (!onLargeScaleDevice)
          const CustomAppBar()
        else
          SliverToBoxAdapter(child: (kToolbarHeight * 2).v),
        BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (context, registrationState) {
            return BlocListener<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserFailed && state.error != null) {
                  CustomSnackbar.of(context).showErrorSnackBar(state.error!);
                } else if (state is UserLoaded) {
                  CustomSnackbar.of(context).showSuccessSnackBar(
                      'Signed up as ${state.userEntity?.firstname}\n${state.userEntity?.id}');
                  Navigator.pushReplacementNamed(context, kSignInRoute);
                }
              },
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailed && state.error != null) {
                    CustomSnackbar.of(context).showErrorSnackBar(state.error!);
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
                  child: onLargeScaleDevice
                      ? Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxWidth: kMaxRequiredMobileSize),
                            child: Card(
                              color:
                                  AppTheme.currentThemeOf(context).background,
                              child:
                                  const SignUpContent(onLargeScaleDevice: true),
                            ),
                          ),
                        )
                      : SignUpContent(
                          signUpType: signUpType,
                          onLargeScaleDevice: onLargeScaleDevice,
                        ),
                ),
              ),
            );
          },
        ),
        if (onLargeScaleDevice) SliverToBoxAdapter(child: kLarge.v),
      ],
    );
  }
}
