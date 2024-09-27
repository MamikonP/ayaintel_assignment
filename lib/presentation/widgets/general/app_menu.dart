import 'package:flutter/material.dart';

import '../../../core/constants/gaps.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/themes/app_theme.dart';
import '../../../l10n/l10n.dart';

class AppMenuBuilder extends StatelessWidget {
  const AppMenuBuilder({
    super.key,
    this.axis = Axis.vertical,
    this.onLargeScaleDevice = false,
  });

  final Axis axis;
  final bool onLargeScaleDevice;

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      AppMenu(
        text: L10n.of(context).tr.lblHomePage,
        onTap: () {},
        axis: axis,
        onLargeScaleDevice: onLargeScaleDevice,
      ),
      AppMenu(
        text: L10n.of(context).tr.lblTeachers,
        onTap: () {},
        axis: axis,
        onLargeScaleDevice: onLargeScaleDevice,
      ),
      AppMenu(
        text: L10n.of(context).tr.lblDonors,
        onTap: () {},
        axis: axis,
        onLargeScaleDevice: onLargeScaleDevice,
      ),
      AppMenu(
        text: L10n.of(context).tr.lblAbout,
        onTap: () {},
        axis: axis,
        onLargeScaleDevice: onLargeScaleDevice,
      ),
      AppMenu(
        text: L10n.of(context).tr.lblContact,
        onTap: () {},
        axis: axis,
        onLargeScaleDevice: onLargeScaleDevice,
      ),
      AppMenu(
        text: L10n.of(context).tr.lblBlog,
        onTap: () {},
        axis: axis,
        onLargeScaleDevice: onLargeScaleDevice,
      ),
    ];
    return axis == Axis.vertical
        ? Column(
            children: menuItems,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map(
                  (e) => Padding(
                    padding: kMedium.all,
                    child: e,
                  ),
                )
                .toList(),
          );
  }
}

class AppMenu extends StatelessWidget {
  const AppMenu(
      {super.key,
      required this.text,
      required this.onTap,
      required this.axis,
      this.onLargeScaleDevice = false});

  final String text;
  final VoidCallback onTap;
  final Axis axis;
  final bool onLargeScaleDevice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: axis == Axis.vertical
          ? CrossAxisAlignment.stretch
          : CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: AppTheme.currentThemeOf(context).bodyText1.copyWith(
              color: onLargeScaleDevice
                  ? AppTheme.currentThemeOf(context).greyScaleLight
                  : AppTheme.currentThemeOf(context).secondary),
        ),
        kMedium.v,
        Divider(
          color: axis == Axis.vertical
              ? AppTheme.currentThemeOf(context).primary
              : AppTheme.currentThemeOf(context).greyScaleLight,
          height: 0.5,
          thickness: 0.5,
        ),
        kMedium.v,
      ],
    );
  }
}
