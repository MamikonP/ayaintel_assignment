import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/enums/app_text_font_weight.dart';
import '../../../core/extensions/app_text_font_weight_values.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/themes/app_theme.dart';
import '../../../l10n/l10n.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../shared/snackbars.dart';
import '../../shared/validator.dart';
import '../../widgets.dart';

class ForgotPasswordContent extends StatefulWidget {
  const ForgotPasswordContent({
    super.key,
    this.onLargeScaleDevice = false,
  });

  final bool onLargeScaleDevice;

  @override
  State<ForgotPasswordContent> createState() => _ForgotPasswordContentState();
}

class _ForgotPasswordContentState extends State<ForgotPasswordContent>
    with AuthControllerMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: kLarger.all,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              L10n.of(context).tr.lblRecoverPassword,
              style: AppTheme.currentThemeOf(context).title1,
              textAlign: TextAlign.center,
            ),
            Text(
              L10n.of(context).tr.lblEnterRecoveryCode,
              style: AppTheme.currentThemeOf(context)
                  .title3
                  .copyWith(fontWeight: AppTextFontWeight.normal.fontWeight),
              textAlign: TextAlign.center,
            ),
            kLarge.v,
            Divider(
              color: AppTheme.currentThemeOf(context).borderColor,
              height: 0.5,
              thickness: 0.5,
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
            const Spacer(),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return AppButton(
                  title: L10n.of(context).tr.btnSend,
                  busy: state is AuthLoading,
                  onTap: () {
                    if (formKey.currentState?.validate() == true) {
                      context.read<AuthBloc>().add(
                            ResetPasswordEvent(email: emailController.text),
                          );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({
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
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailed && state.error != null) {
              CustomSnackbar.of(context).showErrorSnackBar(state.error!);
            } else if (state is PasswordResetLinkSent) {
              CustomSnackbar.of(context).showSuccessSnackBar(
                  L10n.of(context).tr.msgPasswordResetEmailWasSent);
              Navigator.pop(context);
            }
          },
          child: SliverFillRemaining(
            hasScrollBody: false,
            child: onLargeScaleDevice
                ? const ContentCard(
                    widget: ForgotPasswordContent(onLargeScaleDevice: true),
                  )
                : ForgotPasswordContent(
                    onLargeScaleDevice: onLargeScaleDevice,
                  ),
          ),
        ),
      ],
    );
  }
}
