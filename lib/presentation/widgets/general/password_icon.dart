import 'package:flutter/material.dart';

import '../../../core/constants/assets_text.dart';
import '../../../core/constants/gaps.dart';
import '../../../core/extensions/number_extension.dart';
import '../../widgets.dart';

class PasswordIcon extends StatelessWidget {
  const PasswordIcon(this.updatePasswordVisibility, this.obscure, {super.key});

  final VoidCallback updatePasswordVisibility;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kMedium.right,
      child: InkWell(
        onTap: updatePasswordVisibility,
        child: !obscure
            ? RotatedBox(
                quarterTurns: 2,
                child: AssetImageWidget.svg(imageName: AssetsText.icEye))
            : AssetImageWidget.svg(imageName: AssetsText.icEye),
      ),
    );
  }
}
