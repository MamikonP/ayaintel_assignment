import 'package:flutter/material.dart';

Future<T?> showPopup<T>(
  BuildContext context,
  Widget builder, {
  bool dismissible = true,
  bool scrollable = false,
  bool enableDrag = false,
  bool materialWidget = false,
  EdgeInsets padding = EdgeInsets.zero,
  BorderRadius? borderRadius,
  double? height,
}) async {
  return showModalBottomSheet<T>(
    context: context,
    isDismissible: dismissible,
    isScrollControlled: scrollable,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius ??
          const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
    ),
    builder: (_) {
      return Container(
        height: height,
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(child: builder),
          ],
        ),
      );
    },
  );
}
