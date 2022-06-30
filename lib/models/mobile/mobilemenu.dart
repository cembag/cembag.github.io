import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/providers/modelprovider.dart';
import 'package:weloggerweb/screens/home.dart';
import 'package:weloggerweb/screens/screens.dart';
import 'package:weloggerweb/services/services.dart';

class MobileMenu extends StatefulWidget {
  const MobileMenu({Key? key}) : super(key: key);

  @override
  State<MobileMenu> createState() => MobileMenuState();
}

class MobileMenuState extends State<MobileMenu> {

  User? user = FirebaseAuth.instance.currentUser;
  String? userName;
  // Hover
  bool termHover = false;
  bool privacyHover = false;
  bool subscriptionHover = false;
  bool loginLogoutButtonHover = false;

  // Menu
  final Curve _curve = Curves.fastOutSlowIn;

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
    if(user != null) userName = await DbService().getUserInfo(user!.uid);
    if(!mounted) return;
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    ModelProvider modelProvider = Provider.of<ModelProvider>(context, listen: false);
    return Align(
        alignment: Alignment.centerRight,
        child: AnimatedContainer(
          curve: _curve,
          duration: const Duration(seconds: 1),
          height: SizeConfig.screenHeight! - Values.barHeight,
          width: context.watch<ModelProvider>().isMenuOpen ? SizeConfig.screenWidth : 0,
          color: ProjectColors.menuColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _menu(context, modelProvider),
          ),
        ));
  }

  Widget _menu(BuildContext context, ModelProvider modelProvider) {
    return SingleChildScrollView(
      child: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight! - Values.barHeight,
        padding: EdgeInsets.symmetric(horizontal: Values.mobileHorizantalPadding, vertical: Values.mobileMenuVerticalPadding),
        child: userName == null
        ? Space.emptySpace
        : Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            profile(modelProvider),
            term(context),
          ],
        ),
      ),
    );
  }

  Widget term(BuildContext context) {
    return SizedBox(
            width: SizeConfig.screenWidth! - 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: GestureDetector(onTap:() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage())), child: MouseRegion(cursor: SystemMouseCursors.click,onEnter: (_) => setState(() => termHover = true), onExit:(_) => setState(()=> termHover = false),child: _menuItem(context, 'Term of Use', Icons.terminal, termHover ? ProjectColors.customColor : ProjectColors.greyColor, TextAlign.right)))),
                Space.spaceWidth(20),
                Space.dividerVertical(width: 1, color: ProjectColors.greyColor, height: 10),
                Space.spaceWidth(20),
                Expanded(child: GestureDetector(onTap:() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage())), child: MouseRegion(cursor: SystemMouseCursors.click,onEnter: (_) => setState(() => privacyHover = true), onExit:(_) => setState(()=> privacyHover = false),child: _menuItem(context, 'Privacy Policy', Icons.terminal, privacyHover ? ProjectColors.customColor : ProjectColors.greyColor, TextAlign.left)))),
              ],
            ),
          );
  }
  //Expanded(child: GestureDetector(onTap:() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage())), child: MouseRegion(cursor: SystemMouseCursors.click,onEnter: (_) => setState(() => subscriptionHover = true), onExit:(_) => setState(()=> subscriptionHover = false),child: Center(child: _menuItem(context, 'About Subscriptions', Icons.terminal, subscriptionHover ? ProjectColors.customColor : ProjectColors.greyColor))))),

  Widget profile(ModelProvider modelProvider) {
    return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: ProjectColors.transparent, 
                      child: Image(image: ImageEnums.denemepersonicon.assetImage, fit: BoxFit.cover, color: ProjectColors.customColor,),
                    ),
                    Space.spaceWidth(15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProjectText.rText(
                            text: userName!,
                            fontSize: 22),
                        Space.xXSHeight,
                        ProjectText.rText(text: 'user', fontSize: 18, color: ProjectColors.greyColor)
                      ],
                    )
                  ],
                ),
                Icon(
                  Icons.more_horiz,
                  color: ProjectColors.greyColor,
                )
              ],
            ),
            Space.mHeight,
            loginLogoutButton(modelProvider),
          ],
        );
  }

  Widget loginLogoutButton(ModelProvider modelProvider) {
    return GestureDetector(
            onTap: () {
              if (user != null) {
                AuthService().signOut().whenComplete(() {
                  CookieManager.updateUserCookie(isLogin: false);
                  //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
                });
              }
              modelProvider.toggleMenu();
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => loginLogoutButtonHover = true),
              onExit: (_) => setState(() => loginLogoutButtonHover = false),
              child: Container(
                width: SizeConfig.screenWidth! - Values.mobileHorizantalPadding * 2,
                height: 60,
                decoration: BoxDecoration(
                  color: loginLogoutButtonHover ? ProjectColors.opacityDEFb(0.8) : ProjectColors.opacityDEFb(0.4),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(Icons.logout, color: loginLogoutButtonHover ? ProjectColors.customColor : ProjectColors.greyColor, size: 20),
                    Space.mWidth,
                    ProjectText.rText(
                        text: user == null ? 'Log in' : 'Log out',
                        fontSize: Values.fitValue,
                        color: loginLogoutButtonHover ? ProjectColors.customColor : ProjectColors.greyColor),
                  ],
                ),
              ),
            ),
          );
  }
}

Widget _menuItem(BuildContext context, String text, IconData icon, Color color, TextAlign textAlign) {
  return ProjectText.rText(text: text, fontSize: 14, color: color, textAlign: textAlign);
}


