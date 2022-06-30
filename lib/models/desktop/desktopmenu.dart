import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/services/services.dart';

class DesktopMenu extends StatefulWidget {
  const DesktopMenu({Key? key}) : super(key: key);

  @override
  State<DesktopMenu> createState() => _DesktopMenuState();
}

class _DesktopMenuState extends State<DesktopMenu> {

  AuthService authService = AuthService();
  // User variables
  User? user = FirebaseAuth.instance.currentUser;
  String? userName;

  bool logoutHover = false;

  @override
  void initState() {
    getUsername();
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) async {
      user = firebaseUser;
      if(user != null) userName = await DbService().getUserInfo(FirebaseAuth.instance.currentUser!.uid);
      if(!mounted) return;
      setState((){});
    });
    super.initState();
  }

  getUsername() async {
    if(user != null) userName = await DbService().getUserInfo(FirebaseAuth.instance.currentUser!.uid);
    if(!mounted) return;
    setState((){});
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return _signedIn();
  }

  Widget _signedIn() {
    return Container(
        width: Values.desktopMenuWidth,
        height: SizeConfig.screenHeight! - Values.barHeight,
        decoration: const BoxDecoration(border: Border(right: BorderSide(color: Color.fromARGB(255, 180, 180, 180), width: 0.2))),
        padding: const EdgeInsets.all(20),
        child: userName == null
        ? Space.emptySpace
        : Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
              width: 60,
              child: Center(child: FittedBox(child: ProjectText.rText(text: 'PROFILE', fontSize: 12)))),
          Space.xSHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: ImageEnums.denemepersonicon.assetImage, color: ProjectColors.greyColor, width: 60, height: 60),
              Space.sWidth,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(constraints: const BoxConstraints(maxWidth: 80),child: FittedBox(child: Text(userName!, style: const TextStyle(color: Colors.white, fontSize: 22)))),
                  Space.xSWidth,
                  ProjectText.rText(text: 'user', fontSize: 18, color: ProjectColors.greyColor),
                ],
              )
            ],
          ),
          Space.sHeight,
          Visibility(
            visible: user == null ? false : true,
            child: GestureDetector(
              onTap: () => authService.signOut().whenComplete((){
                        CookieManager.updateUserCookie(isLogin: false);
                        Navigator.of(context).popUntil((route) => route.isFirst);}),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() => logoutHover = true),
                onExit: (_) => setState(() => logoutHover = false),
                child: Container(
                  width: SizeConfig.screenWidth! - Values.desktopMenuHorizontalPadding * 2,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.transparent,borderRadius: BorderRadius.circular(40), border: Border.all(color: logoutHover ? ProjectColors.customColor : ProjectColors.greyColor)),
                  padding: EdgeInsets.symmetric(horizontal: Values.desktopMenuHorizontalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProjectText.rText(text: 'Log out', fontSize: 16, color: logoutHover ? ProjectColors.customColor : ProjectColors.greyColor),
                      Icon(Icons.logout, color: logoutHover ? ProjectColors.customColor : ProjectColors.greyColor, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]));
  }
}
