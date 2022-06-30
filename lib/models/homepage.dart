import 'package:flutter/material.dart';
import 'package:weloggerweb/models/dialogadd.dart';
import 'package:weloggerweb/models/models.dart';
import '../products/products.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return _body();
  }
  Widget _body() {
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return SizedBox(
      height: SizeConfig.screenHeight! - Values.barHeight,
      width: SizeConfig.isDesktop! ? SizeConfig.screenWidth! - Values.desktopMenuWidth : SizeConfig.screenWidth,
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildAddNumberButton(context),
              _buildContactUser(),
            ],
          )),
    );
  }

  Widget _buildContactUser() {
    return Stack(
      children: [
        const ContactCard(isHomePage: true),
        _buildContactFlag()
      ],
    );
  }

  Widget _buildAddNumberButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return const DialogAdd();
            });
      },
      child: Container(
          width: SizeConfig.isDesktop! ? SizeConfig.screenWidth! - Values.desktopMenuWidth : SizeConfig.screenWidth,
          height: Values.addNumberButtonHeight,
          decoration: BoxDecoration(
              color: ProjectColors.themeColorMOD3,
              border: Border.all(color: ProjectColors.themeColorMOD2, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: ProjectColors.customColor,
                size: 20,
              ),
              Space.sWidth,
              ProjectText.rText(text: 'Add a number', fontSize: Values.bigValue, color: ProjectColors.themeColorMOD2),
            ],
          )),
    );
  }

  Widget _buildContactFlag() {
    return Positioned(
        top: 20,
        left: SizeConfig.isDesktop!
            ? (SizeConfig.screenWidth! - (Values.contactStatusWidth + Values.desktopMenuWidth + 40)) / 2
            : (SizeConfig.screenWidth! - (Values.contactStatusWidth + 40)) / 2,
        child: Container(
          decoration: BoxDecoration(
              color: ProjectColors.greyColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Values.contactStatusRadius),
                  bottomRight: Radius.circular(Values.contactStatusRadius))),
          padding: ProjectPadding.horizontalPadding(value: 10),
          height: Values.contactStatusHeight,
          width: Values.contactStatusWidth,
          child: Center(
            child: FittedBox(child: ProjectText.rText(text: 'Online', fontSize: Values.xSValue, color: ProjectColors.customColor))),
        ));
  }
}
