import 'package:flutter/material.dart';

class Space {
  static SizedBox spaceWidth(double value) => SizedBox(
        width: value,
      );
  static SizedBox spaceHeight(double value) => SizedBox(
        height: value,
      );

  static SizedBox xXSWidth = const SizedBox(width: 2);
  static SizedBox xSWidth = const SizedBox(width: 5);
  static SizedBox sWidth = const SizedBox(width: 10);
  static SizedBox mWidth = const SizedBox(width: 20);
  static SizedBox lWidth = const SizedBox(width: 30);
  static SizedBox xLWidth = const SizedBox(width: 50);
  static SizedBox xXLWidth = const SizedBox(width: 100);

  static SizedBox xXSHeight = const SizedBox(height: 2);
  static SizedBox xSHeight = const SizedBox(height: 5);
  static SizedBox sHeight = const SizedBox(height: 10);
  static SizedBox mHeight = const SizedBox(height: 20);
  static SizedBox lHeight = const SizedBox(height: 30);
  static SizedBox xLHeight = const SizedBox(height: 50);
  static SizedBox xXLHeight = const SizedBox(height: 100);

  static SizedBox emptySpace = const SizedBox.shrink();
  static Expanded expandedSpace() => const Expanded(child: SizedBox());

  static Container dividerVertical({required double height, Color? color = Colors.white, double? width = 1}) =>
      Container(
        width: width,
        height: height,
        color: color,
      );
  static Container dividerHorizantal({required double width, Color? color = Colors.white, double? height = 1}) =>
      Container(
        width: width,
        height: height,
        color: color,
      );
}
