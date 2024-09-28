import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/themes/app_theme.dart';
import '../../widgets.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.onTap,
    this.size,
    this.radius = kMedium,
    this.backgroundColor,
    this.padding,
    this.busy = false,
  });

  final String title;
  final VoidCallback? onTap;
  final Size? size;
  final double radius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        width: size?.width,
        height: size?.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppTheme.currentThemeOf(context).primary,
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: padding ?? const EdgeInsets.all(kLarge),
        child: !busy
            ? Text(
                title,
                style: AppTheme.currentThemeOf(context).subtitle1.copyWith(
                    color: AppTheme.currentThemeOf(context).onPrimary),
              )
            : Column(
                children: <Widget>[
                  BusyIndicator(
                    valueColor:
                        AppTheme.currentThemeOf(context).colorScheme.primary,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ],
              ),
      ),
    );
  }
}
