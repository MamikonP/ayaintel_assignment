import 'package:flutter/material.dart';

class BusyIndicator extends StatelessWidget {
  const BusyIndicator({
    super.key,
    this.height = 25.0,
    this.width = 25.0,
    this.strokeWidth = 2,
    this.value,
    required this.valueColor,
    required this.backgroundColor,
  });

  final double height;
  final double width;
  final double? value;
  final double strokeWidth;
  final Color valueColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CircularProgressIndicator(
        value: value,
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(valueColor),
        strokeWidth: strokeWidth,
      ),
    );
  }
}
