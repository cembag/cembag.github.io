import 'package:flutter/material.dart';
import '../../products/products.dart';

class DesktopOnboard extends StatefulWidget {
  const DesktopOnboard({Key? key}) : super(key: key);

  @override
  State<DesktopOnboard> createState() => _DesktopOnboardState();
}

class _DesktopOnboardState extends State<DesktopOnboard> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return SizedBox(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: Column(
        children: const [],
      ),
    );
  }
}
