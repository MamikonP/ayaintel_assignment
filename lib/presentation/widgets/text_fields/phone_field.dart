import 'package:flutter/material.dart';
import 'package:flutter_country_selector/flutter_country_selector.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../core/constants.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/themes/app_theme.dart';
import '../../../l10n/l10n.dart';
import '../../shared/modal_sheet.dart';
import 'outline_text_field.dart';

class PhoneField extends StatefulWidget {
  const PhoneField(
      {this.hintText,
      this.required = false,
      this.textInputAction = TextInputAction.done,
      this.onChanged,
      this.validator,
      this.formKey,
      this.isoCountryCode,
      super.key});

  final String? hintText;
  final bool required;
  final TextInputAction textInputAction;
  final void Function(PhoneNumber? phoneNumber)? onChanged;
  final String? Function(PhoneNumber?)? validator;
  final GlobalKey<FormState>? formKey;
  final String? isoCountryCode;

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  final FocusNode _focusNode = FocusNode();
  IsoCode _isoCode = IsoCode.AM;
  final PhoneController _controller = PhoneController(
      initialValue: const PhoneNumber(isoCode: IsoCode.AM, nsn: ''));

  @override
  void initState() {
    super.initState();
    CountrySelector.preloadFlags();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        bottomSheetTheme: BottomSheetThemeData(
          modalBackgroundColor: AppTheme.currentThemeOf(context).greyScaleLight,
        ),
      ),
      child: Center(
        child: PhoneFormField(
          controller: _controller,
          focusNode: _focusNode,
          isCountryButtonPersistent: false,
          isCountrySelectionEnabled: false,
          countryButtonStyle: CountryButtonStyle(
            textStyle: _textStyle,
            showFlag: false,
            showDialCode: false,
            showDropdownIcon: false,
          ),
          textInputAction: widget.textInputAction,
          decoration: DefaultDecoration.of(context).copyWith(
            contentPadding: EdgeInsets.zero,
            prefixIcon: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(kBorderRadius),
                  bottomLeft: Radius.circular(kBorderRadius),
                ),
                border: Border(
                  right: BorderSide(
                      width: kBorderWidth,
                      color: AppTheme.currentThemeOf(context).borderColor),
                ),
              ),
              child: CountryButton(
                isoCode: _controller.value.isoCode,
                textStyle: _textStyle,
                flagSize: 14,
                padding: kLarge.horizontal,
                showDropdownIcon: false,
                onTap: _onDialCodePressed,
              ),
            ),
            hintText: widget.hintText,
            hintStyle: AppTheme.currentThemeOf(context).bodyText1,
            alignLabelWithHint: true,
          ),
          validator: widget.validator ??
              PhoneValidator.compose(<PhoneNumberInputValidator>[
                PhoneValidator.required(context),
                PhoneValidator.validMobile(context),
              ]),
          autofillHints: const <String>[AutofillHints.telephoneNumber],
          onSaved: (PhoneNumber? p) {},
          onChanged: (PhoneNumber? value) {
            if (value != null && value.isoCode != _isoCode) {
              setState(() {
                _isoCode = value.isoCode;
                _controller.value = PhoneNumber(isoCode: _isoCode, nsn: '');
              });
            }
            widget.onChanged?.call(value);
          },
          textAlignVertical: TextAlignVertical.center,
          style: _textStyle,
        ),
      ),
    );
  }

  Future<void> _onDialCodePressed() async => showPopup(
        context,
        Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: const DividerThemeData(
              thickness: 0,
              color: Colors.transparent,
            ),
          ),
          child: CountrySelector.sheet(
            showDialCode: true,
            searchAutofocus: true,
            titleStyle: AppTheme.currentThemeOf(context).bodyText1,
            subtitleStyle: AppTheme.currentThemeOf(context).bodyText1,
            searchBoxTextStyle: AppTheme.currentThemeOf(context).bodyText1,
            searchBoxDecoration: DefaultDecoration.of(
              context,
            ).copyWith(
              hintText: L10n.of(context).tr.lblSearch,
              prefixIcon: Icon(
                Icons.search,
                color: AppTheme.currentThemeOf(context).secondary,
              ),
              contentPadding: EdgeInsets.zero,
              hintStyle: AppTheme.currentThemeOf(context).bodyText1,
            ),
            onCountrySelected: (IsoCode isoCode) {
              setState(() {
                _isoCode = isoCode;
                _controller.value = PhoneNumber(isoCode: _isoCode, nsn: '');
              });
              Navigator.pop(context);
            },
          ) as Widget,
        ),
        height: context.deviceHalfHeight(),
        isScrollControlled: true,
      );

  TextStyle get _textStyle => AppTheme.currentThemeOf(context).bodyText1;
}
