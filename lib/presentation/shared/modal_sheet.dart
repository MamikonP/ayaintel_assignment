import 'package:flutter/material.dart';

import '../../core/constants/ui_constants.dart';
import '../../core/extensions/context_extension.dart';

Future<T?> showPopup<T>(
  BuildContext context,
  Widget builder, {
  bool dismissible = true,
  bool isScrollControlled = false,
  EdgeInsets padding = EdgeInsets.zero,
  BorderRadius? borderRadius,
  double? height,
}) async {
  return showModalBottomSheet<T>(
    context: context,
    isDismissible: dismissible,
    isScrollControlled: isScrollControlled,
    showDragHandle: true,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius ??
          const BorderRadius.only(
            topLeft: Radius.circular(kBorderRadius * 2),
            topRight: Radius.circular(kBorderRadius * 2),
          ),
    ),
    builder: (_) {
      return Container(
        height: height,
        width: context.deviceFullWidth(),
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(child: builder),
          ],
        ),
      );
    },
  );
}
