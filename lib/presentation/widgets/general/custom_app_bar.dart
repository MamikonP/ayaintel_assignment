import 'package:flutter/material.dart';

import '../../../core/constants/assets_text.dart';
import '../../../core/constants/gaps.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/router/route_constants.dart';
import '../../widgets.dart';

class CustomAppBar extends StatelessWidget with AuthenticationMixin {
  const CustomAppBar({super.key, this.onLargeScaleDevice = false});

  final bool onLargeScaleDevice;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      pinned: true,
      title: Column(
        children: [
          AssetImageWidget.svg(imageName: AssetsText.icNextGeneration),
          if (onLargeScaleDevice)
            AppMenuBuilder(
              axis: Axis.horizontal,
              onLargeScaleDevice: onLargeScaleDevice,
            )
        ],
      ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      actions: [
        if (!onLargeScaleDevice)
          IconButton(
            onPressed: () => showHeaderMenu(context),
            icon: const Icon(Icons.menu),
          )
        else
          Column(
            children: [
              Row(
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
              ),
              if (ModalRoute.of(context)?.settings.name != kSignInRoute)
                signInButton(context, onLargeScaleDevice: true),
            ],
          )
      ],
    );
  }
}
