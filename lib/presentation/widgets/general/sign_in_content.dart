import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/constants/gaps.dart';
import '../../../core/constants/ui_constants.dart';
import '../../../core/enums/sign_up_type.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/themes/app_theme.dart';
import '../../../l10n/l10n.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../shared/validator.dart';
import '../../widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        color: AppTheme.currentThemeOf(context).greyScaleLight,
        child: Container(
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
  const SignInContent({
    super.key,
    this.signUpType = SignUpType.teacher,
    this.onLargeScaleDevice = false,
  });

  final SignUpType signUpType;
  final bool onLargeScaleDevice;

  @override
  State<SignInContent> createState() => _SignInContentState();
}

class _SignInContentState extends State<SignInContent>
    with AuthController, AutomaticKeepAliveClientMixin {
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
              AppLocalizations.of(context).lblSignIn,
              style: AppTheme.currentThemeOf(context).title1,
              textAlign: TextAlign.center,
            ),
            Text(
              L10n.of(context).tr.lblWelcome,
              style: AppTheme.currentThemeOf(context).subtitle1,
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
            kExtraLarge.v,
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
                          title: 'Teacher',
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
                          title: 'Donor',
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
                  kExtraLarge.v,
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
