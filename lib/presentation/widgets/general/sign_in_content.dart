import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/enums/app_text_font_weight.dart';
import '../../../core/enums/sign_up_type.dart';
import '../../../core/extensions/app_text_font_weight_values.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/themes/app_theme.dart';
import '../../../l10n/l10n.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/user/user_bloc.dart';
import '../../shared/snackbars.dart';
import '../../shared/validator.dart';
import '../../widgets.dart';

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        hoverColor: AppTheme.currentThemeOf(context).borderColor.withAlpha(5),
        splashColor: AppTheme.currentThemeOf(context).greyScaleLight,
        radius: 2,
        borderRadius: BorderRadius.circular(kBorderRadius),
        child: Container(
          margin: kSmallest.all,
          decoration: BoxDecoration(
            color: AppTheme.currentThemeOf(context).greyScaleLight,
            borderRadius: BorderRadius.circular(kBorderRadius),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color:
                    AppTheme.currentThemeOf(context).borderColor.withAlpha(20),
                blurRadius: 2,
                spreadRadius: 1,
              )
            ],
          ),
          child: Padding(
            padding: kLarge.all,
            child: Text(
              title,
              style: AppTheme.currentThemeOf(context).bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class SignInContent extends StatefulWidget {
  const SignInContent({super.key});

  @override
  State<SignInContent> createState() => _SignInContentState();
}

class _SignInContentState extends State<SignInContent>
    with AuthControllerMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: kLarge.all,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              L10n.of(context).tr.lblSignIn,
              style: AppTheme.currentThemeOf(context).title1,
              textAlign: TextAlign.center,
            ),
            Text(
              L10n.of(context).tr.lblWelcome,
              style: AppTheme.currentThemeOf(context)
                  .title3
                  .copyWith(fontWeight: AppTextFontWeight.normal.fontWeight),
              textAlign: TextAlign.center,
            ),
            kLarge.v,
            OutlineTextField.formField(
              labelText: L10n.of(context).tr.lblEmail,
              validator: Validator.of(context).validateEmail,
              controller: emailController,
              formFieldKey: emailFormKey,
              onChanged: (p0) {
                emailFormKey.currentState?.validate();
              },
            ),
            kLarge.v,
            OutlineTextField.formField(
              labelText: L10n.of(context).tr.lblPassword,
              obscure: true,
              validator: Validator.of(context).validatePassword,
              controller: passwordController,
              formFieldKey: passwordFormKey,
              onChanged: (p0) {
                passwordFormKey.currentState?.validate();
              },
            ),
            kMedium.v,
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: Text(
                  L10n.of(context).tr.btnForgotPassword,
                  style: AppTheme.currentThemeOf(context).bodyText1.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: AppTheme.currentThemeOf(context)
                          .colorScheme
                          .secondary),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    kForgotPasswordRoute,
                  );
                },
              ),
            ),
            kLarge.v,
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return AppButton(
                  title: L10n.of(context).tr.lblSignIn,
                  busy: state is AuthLoading,
                  onTap: () {
                    if (formKey.currentState?.validate() == true) {
                      context.read<AuthBloc>().add(
                            SignInWithEmailPasswordEvent(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                    }
                  },
                );
              },
            ),
            kLarge.v,
            Divider(
              color: AppTheme.currentThemeOf(context).borderColor,
              height: 0.5,
              thickness: 0.5,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(L10n.of(context).tr.lblRegisterAs,
                      style: AppTheme.currentThemeOf(context).bodyText1),
                  kLarge.v,
                  Row(
                    children: [
                      Expanded(
                        child: _RegisterButton(
                          title: L10n.of(context).tr.lblTeacher,
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              kSignUpRoute,
                            );
                          },
                        ),
                      ),
                      kLarge.h,
                      Expanded(
                        child: _RegisterButton(
                          title: L10n.of(context).tr.lblDonor,
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              kSignUpRoute,
                              arguments: SignUpType.donor,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  (context.bottomMenuBar() / 2).v,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
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
                          child: const SignInContent(),
                        ),
                      ),
                    )
                  : const SignInContent(),
            ),
          ),
        ),
        if (onLargeScaleDevice) SliverToBoxAdapter(child: kLarge.v),
      ],
    );
  }
}
