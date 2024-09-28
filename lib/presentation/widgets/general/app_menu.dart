import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/themes/app_theme.dart';
import '../../widgets.dart';

class AppMenuBuilder extends StatelessWidget with MenuMixin {
  const AppMenuBuilder({
    super.key,
    this.axis = Axis.vertical,
    this.onLargeScaleDevice = false,
    this.tabController,
  });

  final Axis axis;
  final bool onLargeScaleDevice;
  final TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return axis == Axis.vertical
        ? Column(
            children: getMenuItems(context)
                .map(
                  (e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e,
                        style: AppTheme.currentThemeOf(context).bodyText1,
                      ),
                      Padding(
                        padding: kSmall.vertical,
                        child: Divider(
                          thickness: kBorderWidth,
                          height: 0,
                          color: AppTheme.currentThemeOf(context)
                              .colorScheme
                              .primary,
                        ),
                      )
                    ],
                  ),
                )
                .toList(),
          )
        : DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
            ),
            child: CustomTabBar(
                getMenuItems(context)
                    .map(
                      (e) => Text(e.toUpperCase()),
                    )
                    .toList(),
                (p0) {},
                tabController));
  }
}
