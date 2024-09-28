import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/themes/app_theme.dart';
import '../../widgets.dart';

class OutlineDropDownField extends StatelessWidget {
  OutlineDropDownField({
    super.key,
    required this.options,
    required this.label,
    this.hintText = '',
    required this.controller,
    this.validator,
    this.onChanged,
  }) : _controllerNotifier = ValueNotifier(controller);

  final List<String> options;
  final String label;
  final String hintText;
  final TextEditingController controller;
  final ValueNotifier<TextEditingController> _controllerNotifier;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ValueListenableBuilder(
          valueListenable: _controllerNotifier,
          builder: (context, value, child) => DropdownButtonFormField<String>(
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            value: value.text.isEmpty ? null : value.text,
            onChanged: (String? newValue) {
              controller.text = newValue ?? '';
              _controllerNotifier.value = controller;
              onChanged?.call(newValue);
            },
            icon: const Icon(Icons.keyboard_arrow_down_sharp),
            iconEnabledColor: AppTheme.currentThemeOf(context).secondary,
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value.isNotEmpty ? value : hintText,
                    style: AppTheme.currentThemeOf(context).bodyText1),
              );
            }).toList(),
            padding: EdgeInsets.zero,
            decoration: DefaultDecoration.of(context).copyWith(
              labelText: label,
              contentPadding: kMedium.all,
              labelStyle: AppTheme.currentThemeOf(context).bodyText1,
            ),
            isExpanded: true,
          ),
        ),
      ],
    );
  }
}
