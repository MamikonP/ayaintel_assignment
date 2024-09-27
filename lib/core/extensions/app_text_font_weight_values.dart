import 'package:flutter/widgets.dart';

import '../enums/app_text_font_weight.dart';

extension AppTextFontWeightValues on AppTextFontWeight {
  FontWeight get fontWeight {
    switch (this) {
      case AppTextFontWeight.thin:
        return FontWeight.w100;
      case AppTextFontWeight.extraLight:
        return FontWeight.w200;
      case AppTextFontWeight.light:
        return FontWeight.w300;
      case AppTextFontWeight.normal:
        return FontWeight.w400;
      case AppTextFontWeight.medium:
        return FontWeight.w500;
      case AppTextFontWeight.semiBold:
        return FontWeight.w600;
      case AppTextFontWeight.bold:
        return FontWeight.w700;
      case AppTextFontWeight.extraBold:
        return FontWeight.w800;
      case AppTextFontWeight.black:
        return FontWeight.w900;
    }
  }
}
