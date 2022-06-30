import 'package:flutter/material.dart';
import 'package:weloggerweb/products/responsive.dart';

class ProjectPadding {
  static double? rSHorizontalPadding;
  static double? rMHorizontalPadding;
  static double? rXHorizontalPadding;
  static double? rSVerticalPadding;
  static double? rMVerticalPadding;
  static double? rXVerticalPadding;

  static EdgeInsets withoutBottomPadding({double top = 20, double left = 20, double right = 20}) =>
      EdgeInsets.only(top: top, left: left, right: right);
  static EdgeInsets horizontalPadding({double value = 20}) => EdgeInsets.symmetric(horizontal: value);

  static void init(BuildContext context) {
    SizeConfig.init(context);

    rSHorizontalPadding = SizeConfig.blockSizeHorizontal! * 1;
    rMHorizontalPadding = SizeConfig.blockSizeVertical! * 1;

    rSVerticalPadding = SizeConfig.blockSizeHorizontal! * 2;
    rSVerticalPadding = SizeConfig.blockSizeVertical! * 2;

    rMVerticalPadding = SizeConfig.blockSizeHorizontal! * 3;
    rXVerticalPadding = SizeConfig.blockSizeVertical! * 3;
  }
}
