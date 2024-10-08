import 'package:flutter/material.dart';

import '../../../core/constants.dart';
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
        child: obscure
            ? AssetImageWidget.svg(imageName: AssetsText.icEyeHidden)
            : AssetImageWidget.svg(imageName: AssetsText.icEye),
      ),
    );
  }
}
