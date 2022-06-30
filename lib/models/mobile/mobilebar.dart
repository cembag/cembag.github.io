import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/providers/modelprovider.dart';
import 'package:weloggerweb/screens/home.dart';

class MobileBar extends StatefulWidget {
  final bool isHomePage;
  const MobileBar({Key? key, required this.isHomePage}) : super(key: key);

  @override
  State<MobileBar> createState() => _MobileBarState();
}

class _MobileBarState extends State<MobileBar> with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: Values.mobileMenuIconAnimationSpeed));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ModelProvider modelProvider = Provider.of<ModelProvider>(context, listen: false);
    return widget.isHomePage ? _buildHomeBar(modelProvider) : _buildDetailsBar(modelProvider);
  }

  Widget _buildHomeBar(ModelProvider modelProvider) {
    return Container(
        height: Values.barHeight,
        width: SizeConfig.screenWidth,
        padding: ProjectPadding.horizontalPadding(value: Values.mobileBarHozizontalPadding),
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 60, 60, 60), Color.fromARGB(255, 20, 20, 20), Color.fromARGB(255, 0, 0, 0)], begin: Alignment.topCenter, end: Alignment.bottomCenter), border: Border(bottom: BorderSide(color: Color.fromARGB(255, 180, 180, 180), width: 0.2))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appName(context),
            _menuButton(modelProvider),
          ],
        ));
  }

  Widget _menuButton(ModelProvider modelProvider) {
    return GestureDetector(
        onTap: () {
          modelProvider.toggleMenu();
          animationControl(modelProvider);
        },
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _controller,
          color: ProjectColors.themeColorMOD2,
          size: 35,
        ));
  }

  Widget _buildDetailsBar(ModelProvider modelProvider) {
    return Container(
        height: Values.barHeight,
        width: SizeConfig.screenWidth,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: ProjectColors.themeColorMOD3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  if (widget.isHomePage) {
                    null;
                  } else {
                    Navigator.pushAndRemoveUntil<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(builder: (BuildContext context) => const HomePage()),
                        (route) => false);
                  }
                },
                child: Icon(Icons.arrow_back, color: ProjectColors.greyColor, size: 30)),
            mobileDetailsTitle(context),
            GestureDetector(
                onTap: () {
                  modelProvider.toggleMenu();
                  animationControl(modelProvider);
                },
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: _controller,
                  color: ProjectColors.themeColorMOD2,
                  size: 35,
                )),
          ],
        ));
  }

  void animationControl(ModelProvider modelProvider) {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    }
    if (_controller.status == AnimationStatus.dismissed) {
      _controller.forward();
    }
    modelProvider.addListener(() { 
      if(!mounted) return;
      _controller.reverse();
    });
  }
}
