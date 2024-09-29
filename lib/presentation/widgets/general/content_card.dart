import 'package:flutter/material.dart';

import '../../../core/constants/gaps.dart';
import '../../../core/constants/ui_constants.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/themes/app_theme.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: kLarger.vertical,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kMaxRequiredMobileSize),
          child: Card(
            color: AppTheme.currentThemeOf(context).background,
            shadowColor:
                AppTheme.currentThemeOf(context).borderColor.withAlpha(50),
            elevation: kLarger,
            child: widget,
          ),
        ),
      ),
    );
  }
}
