import 'package:flutter/material.dart';

import '../../widgets.dart';

mixin SliversMixin {
  final SliverOverlapAbsorberHandle _appBar = SliverOverlapAbsorberHandle();
  final SliverOverlapAbsorberHandle _disconnectBar =
      SliverOverlapAbsorberHandle();

  List<Widget> sliverHeaderBuilder(BuildContext context,
          {bool onLargeScaleDevice = false, TabController? tabController}) =>
      [
        SliverOverlapAbsorber(
          handle: _appBar,
          sliver: CustomAppBar(
            onLargeScaleDevice: onLargeScaleDevice,
          ),
        ),
        SliverOverlapAbsorber(
          handle: _disconnectBar,
          sliver: SliverPersistentHeader(
            pinned: true,
            delegate: PersistentHeaderDelegate(
              AppMenuBuilder(
                axis: Axis.horizontal,
                onLargeScaleDevice: onLargeScaleDevice,
                tabController: tabController,
              ),
            ),
          ),
        )
      ];
}
