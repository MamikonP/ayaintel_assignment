import 'package:flutter/material.dart';

import '../app_theme.dart';

class DarkModeTheme extends AppTheme {
  @override
  Color get background => const Color(0xFFF8F8F8);

  @override
  Color get secondary => const Color(0xFF194866);

  @override
  Color get greyScaleLight => const Color(0xFFFFFFFF);

  @override
  Color get borderColor => const Color(0xFF194866).withOpacity(0.8);

  @override
  Color get snackbarColor => const Color(0xE5252525);

  @override
  Color get primary => const Color(0xFF17BF5F);

  @override
  Color get onPrimary => const Color(0xFFFFFFFF);

  @override
  ColorScheme get colorScheme => ColorScheme(
        primary: primary,
        secondary: secondary,
        surface: background,
        brightness: Brightness.dark,
        error: error,
        onPrimary: onPrimary,
        onSurface: greyScaleLight,
        onError: greyScaleLight,
        onSecondary: greyScaleLight,
      );
}
