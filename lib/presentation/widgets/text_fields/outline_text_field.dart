import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/gaps.dart';
import '../../../core/constants/ui_constants.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/themes/app_theme.dart';
import '../../widgets.dart';

part 'text_field_decoration.dart';

class OutlineTextField extends StatefulWidget {
  const OutlineTextField(
      {super.key,
      this.labelText,
      this.hintText,
      this.suffixIcon,
      this.suffixIconPadding,
      this.prefixIconPadding,
      this.onChanged,
      this.controller,
      this.textInputAction = TextInputAction.done,
      this.textInputType = TextInputType.text,
      this.capitalization = TextCapitalization.none,
      this.maxLines,
      this.minLines = 1,
      this.maxLength,
      this.padding,
      this.outlined = true,
      this.focusNode,
      this.enabled = true,
      this.obscure = false,
      this.borderRadius = kBorderRadius,
      this.borderWidth = kBorderWidth,
      this.filledColor,
      this.maxLengthEnforcement})
      : validator = null,
        formFieldKey = null;

  const OutlineTextField.formField(
      {super.key,
      this.labelText,
      this.hintText,
      this.suffixIcon,
      this.suffixIconPadding,
      this.prefixIconPadding,
      this.onChanged,
      this.controller,
      this.textInputAction = TextInputAction.done,
      this.textInputType = TextInputType.text,
      this.capitalization = TextCapitalization.none,
      this.maxLines,
      this.maxLength,
      this.minLines = 1,
      this.validator,
      this.formFieldKey,
      this.padding,
      this.outlined = true,
      this.focusNode,
      this.enabled = true,
      this.obscure = false,
      this.borderRadius = kBorderRadius,
      this.borderWidth = kBorderWidth,
      this.filledColor,
      this.maxLengthEnforcement});

  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final EdgeInsets? suffixIconPadding;
  final EdgeInsets? prefixIconPadding;
  final void Function(String?)? onChanged;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final TextCapitalization capitalization;
  final TextInputType? textInputType;
  final int? maxLines;
  final int? maxLength;
  final int minLines;
  final String? Function(String?)? validator;
  final GlobalKey<FormFieldState<dynamic>>? formFieldKey;
  final EdgeInsets? padding;
  final bool enabled;
  final bool outlined;
  final bool obscure;
  final FocusNode? focusNode;
  final double borderRadius;
  final double borderWidth;
  final Color? filledColor;
  final MaxLengthEnforcement? maxLengthEnforcement;

  @override
  State<OutlineTextField> createState() => _OutlineTextFieldState();
}

class _OutlineTextFieldState extends State<OutlineTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _focused = false;
  late final TextEditingController _controller;
  bool obscure = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    obscure = widget.obscure;
    if (widget.focusNode == null) {
      _focusNode.addListener(() {
        setState(() {
          _focused = _focusNode.hasFocus;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (widget.validator != null)
          TextFormField(
            maxLength: widget.maxLength,
            maxLengthEnforcement:
                widget.maxLengthEnforcement ?? MaxLengthEnforcement.none,
            enabled: widget.enabled,
            key: widget.formFieldKey,
            focusNode: widget.focusNode ?? _focusNode,
            onChanged: widget.onChanged,
            textInputAction: widget.textInputAction,
            controller: _controller,
            obscureText: obscure,
            maxLines: widget.obscure ? 1 : widget.maxLines,
            minLines: widget.minLines,
            keyboardType: widget.textInputType,
            textAlignVertical: TextAlignVertical.center,
            style: AppTheme.currentThemeOf(context).bodyText1,
            decoration: _decoration(context),
            textCapitalization: widget.capitalization,
            validator: widget.validator,
          )
        else
          TextField(
            maxLength: widget.maxLength,
            maxLengthEnforcement:
                widget.maxLengthEnforcement ?? MaxLengthEnforcement.none,
            enabled: widget.enabled,
            focusNode: widget.focusNode ?? _focusNode,
            onChanged: widget.onChanged,
            obscureText: obscure,
            textInputAction: widget.textInputAction,
            controller: _controller,
            maxLines: widget.obscure ? 1 : widget.maxLines,
            minLines: widget.minLines,
            keyboardType: widget.textInputType,
            textAlignVertical: TextAlignVertical.center,
            style: AppTheme.currentThemeOf(context).bodyText1,
            textCapitalization: widget.capitalization,
            decoration: _decoration(context),
          ),
      ],
    );
  }

  InputDecoration _decoration(BuildContext context) {
    final String? text = _focused ? null : widget.hintText ?? widget.labelText;
    return DefaultDecoration.of(context,
            outlined: widget.outlined,
            borderRadius: widget.borderRadius,
            borderWidth: widget.borderWidth)
        .copyWith(
      filled: widget.filledColor != null,
      fillColor: widget.filledColor,
      isDense: true,
      hintText: text,
      hintStyle: AppTheme.currentThemeOf(context).bodyText1,
      counterText: '',
      suffixIcon: widget.obscure
          ? PasswordIcon(updatePasswordVisibility, obscure)
          : Padding(
              padding:
                  widget.suffixIcon == null ? EdgeInsets.zero : kMedium.all,
              child: widget.suffixIcon,
            ),
      alignLabelWithHint: true,
      contentPadding: widget.padding ?? kLarge.all,
      suffixIconConstraints: const BoxConstraints(
        minHeight: kIconSize,
        minWidth: kIconSize,
      ),
    );
  }

  void updatePasswordVisibility() => setState(() => obscure = !obscure);
}
