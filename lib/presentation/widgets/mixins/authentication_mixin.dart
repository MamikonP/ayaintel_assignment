import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/enums/app_text_font_weight.dart';
import '../../../core/extensions/app_text_font_weight_values.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/number_extension.dart';
import '../../../core/themes/app_theme.dart';
import '../../../l10n/l10n.dart';
import '../../logic/locale/locale_cubit.dart';
import '../../shared/modal_sheet.dart';
import '../../widgets.dart';

mixin AuthenticationMixin {
  List<Widget> getLangaugeItems(BuildContext context,
          {bool onLargeScaleDevice = false}) =>
      [
        InkWell(
            onTap: () {
              if (!onLargeScaleDevice) {
                Navigator.pop(context);
              }
              L10n.of(context).updateLocale(context, L10n.locales[0]);
            },
            child: Text(
              'Eng',
              style: AppTheme.currentThemeOf(context).bodyText3.copyWith(
                    color: onLargeScaleDevice
                        ? AppTheme.currentThemeOf(context).greyScaleLight
                        : AppTheme.currentThemeOf(context).secondary,
                    fontWeight:
                        context.read<LocaleCubit>().state.locale.languageCode ==
                                L10n.locales[0].languageCode
                            ? AppTextFontWeight.bold.fontWeight
                            : AppTextFontWeight.normal.fontWeight,
                  ),
            )),
        InkWell(
          onTap: () {
            if (!onLargeScaleDevice) {
              Navigator.pop(context);
            }
            L10n.of(context).updateLocale(context, L10n.locales[1]);
          },
          child: Text(
            'Հայ',
            style: AppTheme.currentThemeOf(context).bodyText3.copyWith(
                  color: onLargeScaleDevice
                      ? AppTheme.currentThemeOf(context).greyScaleLight
                      : AppTheme.currentThemeOf(context).secondary,
                  fontWeight:
                      context.read<LocaleCubit>().state.locale.languageCode ==
                              L10n.locales[1].languageCode
                          ? AppTextFontWeight.bold.fontWeight
                          : AppTextFontWeight.normal.fontWeight,
                ),
          ),
        ),
        InkWell(
            onTap: () {
              if (!onLargeScaleDevice) {
                Navigator.pop(context);
              }
              L10n.of(context).updateLocale(context, L10n.locales[2]);
            },
            child: Text(
              'Рус',
              style: AppTheme.currentThemeOf(context).bodyText3.copyWith(
                    color: onLargeScaleDevice
                        ? AppTheme.currentThemeOf(context).greyScaleLight
                        : AppTheme.currentThemeOf(context).secondary,
                    fontWeight:
                        context.read<LocaleCubit>().state.locale.languageCode ==
                                L10n.locales[2].languageCode
                            ? AppTextFontWeight.bold.fontWeight
                            : AppTextFontWeight.normal.fontWeight,
                  ),
            )),
      ];

  Widget signInButton(BuildContext context,
          {bool onLargeScaleDevice = false}) =>
      InkWell(
        onTap: () {
          if (!onLargeScaleDevice) {
            Navigator.pop(context);
          }
          Navigator.pushReplacementNamed(context, kSignInRoute);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.login,
              size: 16,
              color: onLargeScaleDevice
                  ? AppTheme.currentThemeOf(context).greyScaleLight
                  : AppTheme.currentThemeOf(context).secondary,
            ),
            kMedium.h,
            Text(
              L10n.of(context).tr.lblSignIn,
              style: AppTheme.currentThemeOf(context).bodyText3.copyWith(
                  color: onLargeScaleDevice
                      ? AppTheme.currentThemeOf(context).greyScaleLight
                      : AppTheme.currentThemeOf(context).secondary),
            ),
          ],
        ),
      );

  void showHeaderMenu(BuildContext context) => showPopup<dynamic>(
        context,
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppMenuBuilder(),
            kLarge.v,
            ...getLangaugeItems(context).map(
              (e) => Column(
                children: [
                  e,
                  kMedium.v,
                ],
              ),
            ),
            kLargest.v,
            if (!context.currentRouteIs(kSignInRoute)) signInButton(context),
            kLarge.v,
          ],
        ),
        isScrollControlled: true,
        padding: kLarge.all,
      );
}
