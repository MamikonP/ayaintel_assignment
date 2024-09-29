import 'package:country_provider2/country_provider2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/enums/app_text_font_weight.dart';
import '../../../core/enums/sign_up_type.dart';
import '../../../core/extensions/app_text_font_weight_values.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/themes/app_theme.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../l10n/l10n.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/registration/registration_bloc.dart';
import '../../logic/user/user_bloc.dart';
import '../../shared/snackbars.dart';
import '../../shared/validator.dart';
import '../../widgets.dart';

class SignUpContent extends StatefulWidget {
  const SignUpContent(
      {super.key,
      this.signUpType = SignUpType.teacher,
      this.onLargeScaleDevice = false});

  final SignUpType signUpType;
  final bool onLargeScaleDevice;

  @override
  State<SignUpContent> createState() => _SignUpContentState();
}

class _SignUpContentState extends State<SignUpContent>
    with AuthControllerMixin, AutomaticKeepAliveClientMixin {
  SignUpType signUpType = SignUpType.teacher;
  final countries = CountryProvider().getAllCountries();

  @override
  void initState() {
    super.initState();
    signUpType = widget.signUpType;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final authButtons = [
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
        child: Text(
          signUpType == SignUpType.donor
              ? L10n.of(context).tr.btnRegisterTeacher
              : L10n.of(context).tr.btnRegisterDonor,
        ),
        onPressed: () {
          if (signUpType == SignUpType.donor) {
            setState(() {
              signUpType = SignUpType.teacher;
            });
          } else {
            setState(() {
              signUpType = SignUpType.donor;
            });
          }
        },
      ),
    ];
    return Padding(
      padding: kLarge.all,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              L10n.of(context).tr.lblSignUp,
              style: AppTheme.currentThemeOf(context).title1,
              textAlign: TextAlign.center,
            ),
            Text(
              L10n.of(context).tr.lblQuickEasy,
              style: AppTheme.currentThemeOf(context)
                  .title3
                  .copyWith(fontWeight: AppTextFontWeight.normal.fontWeight),
              textAlign: TextAlign.center,
            ),
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
            FutureBuilder(
              future: countries,
              builder: (context, snapshot) => OutlineDropDownField(
                hintText: L10n.of(context).tr.lblRegion,
                options: snapshot.data?.map((e) => e.name ?? '').toList() ?? [],
                label: L10n.of(context).tr.lblRegion,
                validator: Validator.of(context).validateEmptyField,
                onChanged: (value) => context
                    .read<RegistrationBloc>()
                    .add(UpdateRegionEvent(value)),
              ),
            ),
            kLarge.v,
            // ! Simulating cities as countries reversed
            FutureBuilder(
              future: countries,
              builder: (context, snapshot) => OutlineDropDownField(
                hintText: L10n.of(context).tr.lblCity,
                options: snapshot.data
                        ?.map((e) => e.name ?? '')
                        .toList()
                        .reversed
                        .toList() ??
                    [],
                label: L10n.of(context).tr.lblCity,
                validator: Validator.of(context).validateEmptyField,
                onChanged: (value) => context
                    .read<RegistrationBloc>()
                    .add(UpdateCityEvent(value)),
              ),
            ),
            if (signUpType == SignUpType.teacher) ...[
              kLarge.v,
              OutlineDropDownField(
                hintText: L10n.of(context).tr.lblSchool,
                options: kSchoolNames,
                label: L10n.of(context).tr.lblSchool,
                validator: Validator.of(context).validateEmptyField,
                onChanged: (value) => context
                    .read<RegistrationBloc>()
                    .add(UpdateSchoolEvent(value)),
              ),
              kLarge.v,
              OutlineDropDownField(
                hintText: L10n.of(context).tr.lblSubject,
                options: kSchoolSubjects,
                label: L10n.of(context).tr.lblSubject,
                validator: Validator.of(context).validateEmptyField,
                selectable: true,
                onChanged: (value) => context
                    .read<RegistrationBloc>()
                    .add(UpdateSubjectEvent([value ?? ''])),
              ),
              kLarge.v,
              OutlineDropDownField(
                hintText: L10n.of(context).tr.lblGrade,
                options: kGradeList,
                label: L10n.of(context).tr.lblGrade,
                validator: Validator.of(context).validateEmptyField,
                selectable: true,
                onChanged: (value) => context
                    .read<RegistrationBloc>()
                    .add(UpdateGradeEvent([value ?? '1'])),
              ),
            ],
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
            if (widget.onLargeScaleDevice)
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: authButtons.reversed.toList(),
              )
            else
              ...authButtons
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
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
                      ? const ContentCard(
                          widget: SignUpContent(onLargeScaleDevice: true))
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
