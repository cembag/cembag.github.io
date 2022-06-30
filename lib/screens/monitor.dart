import 'package:flutter/material.dart';
import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/products/products.dart';

class Monitor extends StatelessWidget {
  const Monitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return Scaffold(
      body: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            const WebBar(),
            SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight! - Values.barHeight,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizeConfig.isDesktop!
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              DesktopMenu(),
                              HomeBody(),
                            ],
                          )
                        : Stack(
                            children: const [HomeBody(), MobileMenu()],
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
