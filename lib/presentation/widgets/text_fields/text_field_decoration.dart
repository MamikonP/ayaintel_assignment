part of 'outline_text_field.dart';

class DefaultDecoration extends InputDecoration {
  const DefaultDecoration.of(
    this.context, {
    this.outlined = true,
    this.borderRadius = kBorderRadius,
    this.borderWidth = kBorderWidth,
  });

  final BuildContext context;
  final bool outlined;
  final double borderRadius;
  final double borderWidth;

  @override
  TextStyle? get hintStyle => AppTheme.currentThemeOf(context).bodyText1;

  @override
  TextStyle? get labelStyle => AppTheme.currentThemeOf(context).bodyText1;

  @override
  InputBorder? get enabledBorder => !outlined ? null : _outlineInputBorder;

  @override
  InputBorder? get disabledBorder => !outlined ? null : _outlineInputBorder;

  @override
  InputBorder? get border => !outlined ? InputBorder.none : _outlineInputBorder;

  @override
  InputBorder? get focusedBorder =>
      !outlined ? InputBorder.none : _outlineInputBorder;

  @override
  TextStyle? get errorStyle =>
      AppTheme.currentThemeOf(context).bodyText2.copyWith(
            color: AppTheme.currentThemeOf(context).error,
            fontWeight: AppTextFontWeight.normal.fontWeight,
          );

  @override
  InputBorder? get errorBorder => !outlined
      ? InputBorder.none
      : OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: AppTheme.currentThemeOf(context).error,
            width: borderWidth,
            style: borderWidth == 0 ? BorderStyle.none : BorderStyle.solid,
          ),
        );

  @override
  InputBorder? get focusedErrorBorder =>
      !outlined ? InputBorder.none : errorBorder;

  OutlineInputBorder get _outlineInputBorder => OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
          color: AppTheme.currentThemeOf(context).borderColor,
          width: borderWidth,
          style: borderWidth == 0 ? BorderStyle.none : BorderStyle.solid));
}
