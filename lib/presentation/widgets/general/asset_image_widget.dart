// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ImageType { png, svg }

class AssetImageWidget extends StatelessWidget {
  AssetImageWidget.png(
      {required this.imageName,
      this.boxFit = BoxFit.cover,
      this.width,
      this.height,
      this.opacity,
      super.key})
      : imageType = ImageType.png,
        color = null;

  AssetImageWidget.svg(
      {required this.imageName,
      this.boxFit = BoxFit.cover,
      this.width,
      this.height,
      this.color,
      super.key})
      : imageType = ImageType.svg,
        opacity = null;

  final ImageType imageType;
  final Color? color;
  final String imageName;
  final BoxFit boxFit;
  final double? width;
  final double? height;
  final Animation<double>? opacity;

  @override
  Widget build(BuildContext context) {
    if (imageType == ImageType.svg) {
      return SvgPicture.asset(
        imageName,
        fit: boxFit,
        height: height,
        width: width,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      );
    }
    return Image.asset(
      imageName,
      fit: boxFit,
      height: height,
      width: width,
      opacity: opacity,
    );
  }
}
