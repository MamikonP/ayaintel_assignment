import 'package:flutter/material.dart';

extension NumberExtension on double {
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: this);
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: this);
  EdgeInsets get top => EdgeInsets.only(top: this);
  EdgeInsets get bottom => EdgeInsets.only(bottom: this);
  EdgeInsets get right => EdgeInsets.only(right: this);
  EdgeInsets get left => EdgeInsets.only(left: this);
  EdgeInsets get all => EdgeInsets.all(this);

  SizedBox get h => SizedBox(width: this);
  SizedBox get v => SizedBox(height: this);
}
