import 'package:flutter/material.dart';

import '../../../core/extensions/context_extension.dart';

class PersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  PersistentHeaderDelegate(this.widget);
  final Widget widget;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: context.deviceFullWidth(),
        child: widget,
      ),
    );
  }

  @override
  double get maxExtent => kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
