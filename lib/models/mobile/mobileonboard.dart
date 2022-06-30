import 'package:flutter/material.dart';
import 'package:weloggerweb/models/onboardwidgets.dart';
import 'package:weloggerweb/products/image.dart';
import 'package:weloggerweb/screens/home.dart';

class MobileOnboardOne extends StatelessWidget {
  const MobileOnboardOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BuildOnboard(
        image: ImageEnums.mobileonboardone.assetImage,
        header: 'Online Tracker',
        text: 'Online Tracker',
        nextPage: const MobileOnboardTwo(),
        index: 0),
    );
  }
}

class MobileOnboardTwo extends StatelessWidget {
  const MobileOnboardTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BuildOnboard(
        image: ImageEnums.mobileonboardtwo.assetImage,
        header: 'Activity Tracker',
        text: 'Track your family member',
        nextPage: const MobileOnboardThree(),
        index: 1),
    );
  }
}

class MobileOnboardThree extends StatelessWidget {
  const MobileOnboardThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BuildOnboard(
        image: ImageEnums.mobileonboardthree.assetImage,
        header: 'delete',
        text: 'deneme',
        nextPage: const HomePage(),
        isViewed: true,
        index: 2),
    );
  }
}
