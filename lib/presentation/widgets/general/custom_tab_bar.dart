import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/enums/app_text_font_weight.dart';
import '../../../core/extensions/app_text_font_weight_values.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/themes/app_theme.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar(this.tabs, this.onTap, this.tabController, {super.key});

  final List<Widget> tabs;
  final void Function(int) onTap;
  final TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kSmall.vertical,
      child: TabBar(
        tabs: tabs,
        onTap: onTap,
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
        indicatorWeight: 1,
        tabAlignment: TabAlignment.center,
        overlayColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
        labelPadding: kSmall.all.copyWith(left: kLarge, right: kLarge),
        padding: EdgeInsets.zero,
        isScrollable: true,
        indicatorColor:
            AppTheme.currentThemeOf(context).colorScheme.onSecondary,
        labelColor: AppTheme.currentThemeOf(context).colorScheme.onSecondary,
        unselectedLabelColor:
            AppTheme.currentThemeOf(context).colorScheme.onSecondary,
        unselectedLabelStyle: AppTheme.currentThemeOf(context).bodyText2,
        labelStyle: AppTheme.currentThemeOf(context)
            .bodyText2
            .copyWith(fontWeight: AppTextFontWeight.medium.fontWeight),
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
