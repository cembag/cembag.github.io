import 'package:flutter/material.dart';
import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/products/products.dart';

class WebBar extends StatefulWidget {
  const WebBar({Key? key}) : super(key: key);

  @override
  State<WebBar> createState() => _WebBarState();
}

class _WebBarState extends State<WebBar> {

  @override
  Widget build(BuildContext context) {
    init(context);

    return SizeConfig.isMobile! ? _mobileBar(context) : _desktopBar(context);
  }

  Widget _mobileBar(BuildContext context) {
    return const MobileBar(isHomePage: true);
  }

  Widget _desktopBar(BuildContext context) {
    return const DesktopBar();
  }

  void init(BuildContext context) {
    SizeConfig.init(context);
    SizeConfig.getDevice();
  }
}
