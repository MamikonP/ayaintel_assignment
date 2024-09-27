import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/gaps.dart';
import '../../../core/enums/sign_up_type.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../l10n/l10n.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/registration/registration_bloc.dart';
import '../../shared/validator.dart';
import '../../widgets.dart';

mixin _Controllers {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final regionController = TextEditingController();
  final cityController = TextEditingController();
  final schoolController = TextEditingController();
  final subjectController = TextEditingController();
  final gradeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final nameFormKey = GlobalKey<FormFieldState<dynamic>>();
  final surnameFormKey = GlobalKey<FormFieldState<dynamic>>();
  final emailFormKey = GlobalKey<FormFieldState<dynamic>>();
  final passwordFormKey = GlobalKey<FormFieldState<dynamic>>();
  final confirmPasswordFormKey = GlobalKey<FormFieldState<dynamic>>();
}

class SignUpContent extends StatefulWidget {
  const SignUpContent({super.key, this.signUpType = SignUpType.teacher});

  final SignUpType signUpType;

  @override
  State<SignUpContent> createState() => _SignUpContentState();
}

class _SignUpContentState extends State<SignUpContent>
    with _Controllers, AutomaticKeepAliveClientMixin {
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
            kLarge.v,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: OutlineTextField.formField(
                    formFieldKey: nameFormKey,
                    labelText: L10n.of(context).tr.lblName,
                    validator: Validator.of(context).validateFirstName,
                    controller: nameController,
                    onChanged: (p0) {
                      if (nameFormKey.currentState?.validate() == true) {
                        context
                            .read<RegistrationBloc>()
                            .add(UpdateFirstNameEvent(p0));
                      }
                    },
                  ),
                ),
                kLarge.h,
                Expanded(
                  child: OutlineTextField.formField(
                    labelText: L10n.of(context).tr.lblSurname,
                    validator: Validator.of(context).validateSurname,
                    controller: surnameController,
                    formFieldKey: surnameFormKey,
                    onChanged: (p0) {
                      if (surnameFormKey.currentState?.validate() == true) {
                        context
                            .read<RegistrationBloc>()
                            .add(UpdateLastNameEvent(p0));
                      }
                    },
                  ),
                ),
              ],
            ),
            kLarge.v,
            OutlineTextField.formField(
              labelText: L10n.of(context).tr.lblEmail,
              validator: Validator.of(context).validateEmail,
              controller: emailController,
              formFieldKey: emailFormKey,
              onChanged: (p0) {
                if (emailFormKey.currentState?.validate() == true) {
                  context.read<RegistrationBloc>().add(UpdateEmailEvent(p0));
                }
              },
            ),
            kLarge.v,
            PhoneField(
              hintText: L10n.of(context).tr.lblPhoneNumber,
              validator: Validator.of(context).validatePhoneNumber,
              onChanged: (phoneNumber) {
                context.read<RegistrationBloc>().add(phoneNumber?.isValid() ==
                        true
                    ? UpdatePhoneNumberEvent(
                        phoneNumber?.international, phoneNumber?.countryCode)
                    : const UpdatePhoneNumberEvent('', ''));
              },
            ),
            kLarge.v,
            OutlineDropDownField(
              hintText: L10n.of(context).tr.lblRegion,
              options: ['1', '2'],
              label: 'Region',
              controller: regionController,
              validator: Validator.of(context).validateEmptyField,
              onChanged: (value) => context
                  .read<RegistrationBloc>()
                  .add(UpdateRegionEvent(value)),
            ),
            kLarge.v,
            OutlineDropDownField(
              hintText: L10n.of(context).tr.lblCity,
              options: ['1', '2'],
              label: 'City',
              controller: cityController,
              validator: Validator.of(context).validateEmptyField,
              onChanged: (value) =>
                  context.read<RegistrationBloc>().add(UpdateCityEvent(value)),
            ),
            kLarge.v,
            OutlineDropDownField(
              hintText: L10n.of(context).tr.lblSchool,
              options: ['1', '2'],
              label: 'School',
              controller: schoolController,
              validator: Validator.of(context).validateEmptyField,
              onChanged: (value) => context
                  .read<RegistrationBloc>()
                  .add(UpdateSchoolEvent(value)),
            ),
            kLarge.v,
            OutlineDropDownField(
              hintText: L10n.of(context).tr.lblSubject,
              options: ['1', '2'],
              label: 'Subject',
              controller: subjectController,
              validator: Validator.of(context).validateEmptyField,
              onChanged: (value) => context
                  .read<RegistrationBloc>()
                  .add(UpdateSubjectEvent([value ?? ''])),
            ),
            kLarge.v,
            OutlineDropDownField(
              hintText: L10n.of(context).tr.lblGrade,
              options: ['1', '2'],
              label: 'Grade',
              controller: gradeController,
              validator: Validator.of(context).validateEmptyField,
              onChanged: (value) => context
                  .read<RegistrationBloc>()
                  .add(UpdateGradeEvent([value ?? '1'])),
            ),
            kLarge.v,
            OutlineTextField.formField(
              labelText: L10n.of(context).tr.lblPassword,
              obscure: true,
              validator: Validator.of(context).validatePassword,
              controller: passwordController,
              formFieldKey: passwordFormKey,
              onChanged: (p0) {
                if (passwordFormKey.currentState?.validate() == true) {
                  context.read<RegistrationBloc>().add(UpdatePasswordEvent(p0));
                }
              },
            ),
            kLarge.v,
            OutlineTextField.formField(
              labelText: L10n.of(context).tr.lblConfirmPassword,
              obscure: true,
              validator: (value) => Validator.of(context)
                  .validateConfirmPassword(value, passwordController.text),
              controller: confirmPasswordController,
              formFieldKey: confirmPasswordFormKey,
              onChanged: (p0) {
                if (confirmPasswordFormKey.currentState?.validate() == true) {
                  context
                      .read<RegistrationBloc>()
                      .add(UpdateConfirmPasswordEvent(p0));
                }
              },
            ),
            kExtraLarge.v,
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return AppButton(
                  title: L10n.of(context).tr.btnOK,
                  busy: state is AuthLoading,
                  onTap: () {
                    if (formKey.currentState?.validate() == true) {
                      context.read<AuthBloc>().add(
                            SignUpWithEmailPasswordEvent(
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
            TextButton(
              child: Text(L10n.of(context).tr.btnRegisterDonor),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
