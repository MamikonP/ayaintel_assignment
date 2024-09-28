import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/enums/sign_up_type.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/themes/app_theme.dart';
import '../../../l10n/l10n.dart';
import '../../screens.dart';

class WebTabBarContent extends StatelessWidget {
  const WebTabBarContent(
      {super.key,
      required this.tabController,
      this.signUpType = SignUpType.teacher});

  final TabController tabController;
  final SignUpType signUpType;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: tabController,
      //! Simulating empty views for now
      children: List.generate(
        5,
        (index) => Center(
          child: Text(
            L10n.of(context).tr.lblComingSoon,
            style: AppTheme.currentThemeOf(context).title1,
          ),
        ),
      )..insert(
          0,
          context.currentRouteIs(kSignInRoute)
              ? const SignInBody(onLargeScaleDevice: true)
              : SignUpBody(
                  signUpType: signUpType,
                  onLargeScaleDevice: true,
                ),
        ),
    );
  }
}
