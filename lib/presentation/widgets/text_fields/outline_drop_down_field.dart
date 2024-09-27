import 'package:flutter/material.dart';

import '../../../core/constants/gaps.dart';
import '../../../core/constants/ui_constants.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/themes/app_theme.dart';

class OutlineDropDownField extends StatelessWidget {
  OutlineDropDownField({
    super.key,
    required this.options,
    required this.label,
    this.hintText = '',
    required this.controller,
  }) : _controllerNotifier = ValueNotifier(controller);

  final List<String> options;
  final String label;
  final String hintText;
  final TextEditingController controller;
  final ValueNotifier<TextEditingController> _controllerNotifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kMedium.horizontal,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        border: Border.all(
            color: AppTheme.currentThemeOf(context).borderColor,
            width: kBorderWidth),
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ValueListenableBuilder(
            valueListenable: _controllerNotifier,
            builder: (context, value, child) => DropdownButtonFormField<String>(
              value: value.text.isEmpty ? null : value.text,
              onChanged: (String? newValue) {
                controller.text = newValue ?? '';
                _controllerNotifier.value = controller;
              },
              items: options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.isNotEmpty ? value : hintText,
                      style: AppTheme.currentThemeOf(context).bodyText1),
                );
              }).toList(),
              padding: EdgeInsets.zero,
              decoration: InputDecoration(
                labelText: label,
                border: InputBorder.none,
                contentPadding: kMedium.all,
                labelStyle: AppTheme.currentThemeOf(context).bodyText1,
              ),
              isExpanded: true,
            ),
          ),
        ],
      ),
    );
  }
}
