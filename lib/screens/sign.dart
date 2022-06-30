import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/providers/providers.dart';

class Sign extends StatefulWidget {
  const Sign({
    Key? key,
  }) : super(key: key);

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  ModelProvider? modelProvider;

  @override
  Widget build(BuildContext context) {
    modelProvider = Provider.of<ModelProvider>(context);
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return SizedBox(
        width: SizeConfig.screenWidth!,
        height: SizeConfig.screenHeight!,
        child: Column(
          children: [
            const WebBar(),
            SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight! - Values.barHeight,
              child: SizeConfig.isDesktop! ? 
                    Row(children: [
                      const DesktopMenu(),
                      IndexedStack(
                        alignment: Alignment.center,
                        index: modelProvider!.signState,
                        children: const [
                          LoginPage(),
                          SignUpPage(),
                        ],
                      ),
                    ])
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        IndexedStack(
                          alignment: Alignment.center,
                          index: modelProvider!.signState,
                          children: const [
                            LoginPage(),
                            SignUpPage(),
                          ],
                        ),
                        const MobileMenu()
                      ],
                    ),
            ),
          ],
        ));
  }
}
