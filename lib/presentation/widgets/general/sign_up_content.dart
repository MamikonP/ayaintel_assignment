import 'package:flutter/material.dart';

import '../../../core/constants/gaps.dart';
import '../../../core/enums/sign_up_type.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../l10n/l10n.dart';
import '../../widgets.dart';

class SignUpContent extends StatelessWidget {
  const SignUpContent({super.key, this.signUpType = SignUpType.teacher});

  final SignUpType signUpType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kLarge.all,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          kLarge.v,
          Row(
            children: [
              Expanded(
                child: OutlineTextField.formField(
                  hintText: L10n.of(context).tr.lblName,
                ),
              ),
              kLarge.h,
              Expanded(
                child: OutlineTextField.formField(
                  hintText: L10n.of(context).tr.lblSurname,
                ),
              ),
            ],
          ),
          kLarge.v,
          OutlineTextField.formField(
                  hintText: L10n.of(context).tr.lblEmail,
          ),
          kLarge.v,
          PhoneField(
                  hintText: L10n.of(context).tr.lblPhoneNumber,
          ),
          kLarge.v,
          OutlineDropDownField(
            hintText: 'Region',
            options: ['1', '2'],
            label: 'Region',
            controller: TextEditingController(),
          ),
          kLarge.v,
          OutlineDropDownField(
            hintText: 'City',
            options: ['1', '2'],
            label: 'City',
            controller: TextEditingController(),
          ),
          kLarge.v,
          OutlineDropDownField(
            hintText: 'School',
            options: ['1', '2'],
            label: 'School',
            controller: TextEditingController(),
          ),
          kLarge.v,
          OutlineDropDownField(
            hintText: 'Subject',
            options: ['1', '2'],
            label: 'Subject',
            controller: TextEditingController(),
          ),
          kLarge.v,
          OutlineDropDownField(
            hintText: 'Grade',
            options: ['1', '2'],
            label: 'Grade',
            controller: TextEditingController(),
          ),
          kLarge.v,
          OutlineTextField.formField(
            hintText: 'Password',
            obscure: true,
          ),
          kLarge.v,
          OutlineTextField.formField(
            hintText: 'Confirm Password',
            obscure: true,
          ),
          kExtraLarge.v,
          AppButton(title: 'Ok'),
          kLarge.v,
          TextButton(
            child: Text('Register as a Donor'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
