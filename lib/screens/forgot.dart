import 'package:flutter/material.dart';
import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/products/products.dart';

class Forgot extends StatelessWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return Scaffold(
      body: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const WebBar(),
            SizeConfig.isDesktop!
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      DesktopMenu(),
                      ForgotPage(),
                    ],
                  )
                : Stack(
                    children: const [ForgotPage(), MobileMenu()],
                  )
          ],
        ),
      ),
    );
  }
}
