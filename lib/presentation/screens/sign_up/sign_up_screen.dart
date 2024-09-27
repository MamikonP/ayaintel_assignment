import 'package:flutter/material.dart';

import '../../../core/constants/assets_text.dart';
import '../../widgets.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: AssetImageWidget.svg(imageName: AssetsText.icNextGeneration),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          ),
          const SliverFillRemaining(
            hasScrollBody: false,
            child: SignUpContent(),
          )
        ],
      ),
    );
  }
}
