import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/enums/sign_up_type.dart';
import '../../widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.signUpType});

  final SignUpType signUpType;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with AuthenticationMixin, SingleTickerProviderStateMixin, SliversMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: kTabBarSize, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        body: constraints.maxWidth > kMaxRequiredMobileSize
            ? NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) =>
                    sliverHeaderBuilder(
                  context,
                  onLargeScaleDevice:
                      constraints.maxWidth > kMaxRequiredMobileSize,
                  tabController: _tabController,
                ),
                body: WebTabBarContent(tabController: _tabController),
              )
            : SignUpBody(signUpType: widget.signUpType),
      ),
    );
  }
}
