import 'package:flutter/material.dart';
import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/providers/providers.dart';

class OnboardPages extends StatefulWidget {
  const OnboardPages({Key? key}) : super(key: key);

  @override
  State<OnboardPages> createState() => _OnboardPagesState();
}

class _OnboardPagesState extends State<OnboardPages> {
  bool? isViewed;

  @override
  void initState() {
    getView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return SizeConfig.isMobile!
        ? isViewed == null
            ? const MobileOnboardOne()
            : const HomeBody()
        : const DesktopOnboard();
  }

  Future<void> getView() async {
    isViewed = PreferencesProvider.isViewed;
  }
}
