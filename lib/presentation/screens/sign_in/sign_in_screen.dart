import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/themes/app_theme.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/user/user_bloc.dart';
import '../../shared/snackbars.dart';
import '../../widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
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
            : const SignInBody(),
      ),
    );
  }
}

class SignInBody extends StatelessWidget {
  const SignInBody({
    super.key,
    this.onLargeScaleDevice = false,
  });

  final bool onLargeScaleDevice;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        if (!onLargeScaleDevice)
          CustomAppBar(onLargeScaleDevice: onLargeScaleDevice)
        else
          SliverToBoxAdapter(child: (kToolbarHeight * 2).v),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserFailed && state.error != null) {
              CustomSnackbar.of(context).showErrorSnackBar(state.error!);
            } else if (state is UserLoaded) {
              CustomSnackbar.of(context).showSuccessSnackBar(
                  'Logged in as ${state.userEntity?.firstname}\n${state.userEntity?.id}');
            }
          },
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailed && state.error != null) {
                CustomSnackbar.of(context).showErrorSnackBar(state.error!);
              } else if (state is AuthLoaded) {
                context.read<UserBloc>().add(
                      GetUserEvent(userId: state.userId ?? ''),
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
                          color: AppTheme.currentThemeOf(context).background,
                          child: const SignInContent(onLargeScaleDevice: true),
                        ),
                      ),
                    )
                  : SignInContent(
                      onLargeScaleDevice: onLargeScaleDevice,
                    ),
            ),
          ),
        ),
        if (onLargeScaleDevice) SliverToBoxAdapter(child: kLarge.v),
      ],
    );
  }
}
