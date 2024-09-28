import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double deviceWidthOf({required final double percent}) =>
      MediaQuery.sizeOf(this).width * percent / 100;

  double deviceHeightOf({required final double percent}) =>
      MediaQuery.sizeOf(this).height * percent / 100;

  double deviceFullWidth() => deviceWidthOf(percent: 100);

  double deviceFullHeight() => deviceHeightOf(percent: 100);

  double deviceHalfWidth() => deviceFullWidth() / 2;

  double deviceHalfHeight() => deviceFullHeight() / 2;

  double topStatusBar() => MediaQuery.viewPaddingOf(this).top;

  bool currentRouteIs(String route) =>
      ModalRoute.of(this)?.settings.name == route;
}
