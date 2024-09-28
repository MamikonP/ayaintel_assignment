import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/themes/app_theme.dart';
import '../../../l10n/l10n.dart';
import '../../widgets.dart';

class CustomAppBar extends StatelessWidget with AuthenticationMixin {
  const CustomAppBar({
    super.key,
    this.onLargeScaleDevice = false,
  });

  final bool onLargeScaleDevice;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      pinned: true,
      collapsedHeight: kTextTabBarHeight + kLargest,
      flexibleSpace: SizedBox(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (!context.currentRouteIs(kSignInRoute) && onLargeScaleDevice)
              Positioned(
                right: kLargest,
                bottom: 0,
                child: signInButton(context, onLargeScaleDevice: true),
              ),
            Align(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (context.topStatusBar() / 2).v,
                  AssetImageWidget.svg(imageName: AssetsText.icNextGeneration),
                  Text(
                    L10n.of(context).tr.lblNextGeneration,
                    style: _titleStyle(context),
                  ),
                  Text(
                    L10n.of(context).tr.lblArmenia,
                    style: _titleStyle(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      actions: [
        if (!onLargeScaleDevice)
          IconButton(
            onPressed: () => showHeaderMenu(context),
            icon: const Icon(Icons.menu),
          )
        else
          Row(
            mainAxisSize: MainAxisSize.min,
            children: getLangaugeItems(context, onLargeScaleDevice: true)
                .map(
                  (e) => Row(
                    children: [
                      e,
                      kMedium.h,
                    ],
                  ),
                )
                .toList(),
          )
      ],
    );
  }

  TextStyle _titleStyle(BuildContext context) =>
      AppTheme.currentThemeOf(context).bodyText2.copyWith(
            height: 1,
            color: AppTheme.currentThemeOf(context).colorScheme.onPrimary,
          );
}
