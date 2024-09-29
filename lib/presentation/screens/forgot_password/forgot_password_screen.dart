import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
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
            : const ForgotPasswordBody(),
      ),
    );
  }
}
