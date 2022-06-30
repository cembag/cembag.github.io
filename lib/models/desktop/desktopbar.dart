import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weloggerweb/globalvalues/globalvalues.dart';
import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/services/services.dart';

class DesktopBar extends StatefulWidget {
  const DesktopBar({Key? key}) : super(key: key);

  @override
  State<DesktopBar> createState() => _DesktopBarState();
}

class _DesktopBarState extends State<DesktopBar> {
  // FirebaseAuth
  final FirebaseAuth auth = FirebaseAuth.instance;

  // User variables
  User? user = FirebaseAuth.instance.currentUser;
  String? userName;

  bool termHover = false;
  bool policyHover = false;
  bool subscriptionHover = false;


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
    SizeConfig.init(context);
    return Container(
        height: 80,
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.symmetric(horizontal: Values.desktopBarHorizontalPadding),
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 60, 60, 60), Color.fromARGB(255, 20, 20, 20), Color.fromARGB(255, 0, 0, 0)], begin: Alignment.topCenter, end: Alignment.bottomCenter), border: Border(bottom: BorderSide(color: Color.fromARGB(255, 180, 180, 180), width: 0.2))),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [appName(context), _login()],
          ),
        ));
  }

  Widget _login() {
    final AuthService authService = AuthService();
    return SizeConfig.isTablet! ? _tabletUser(authService) : _terms();
  }

  Widget _tabletUser(AuthService authService) {
    return user == null
        ? MouseRegion(
            onEnter: (_) => controller.doorHover.value = true,
            onExit: (_) => controller.doorHover.value = false,
            child: Image(
                  image: AssetImage(
                      controller.doorHover.value ? 'assets/images/ic_opendoor.png' : 'assets/images/ic_closedoor.png'),
                  color: ProjectColors.customColor,
                  width: 30,
                  height: 30,
                ))
        : userName == null
            ? CircularProgressIndicator(
                color: ProjectColors.customColor,
              )
            : Row(
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ProjectText.rText(
                            text: userName!,
                            fontSize: 16,
                            color: ProjectColors.customColor,
                          ),
                          ProjectText.rText(
                            text: 'user',
                            fontSize: 14,
                            color: ProjectColors.greyColor,
                          ),
                        ],
                      ),
                      Space.sWidth,
                      Image(image: ImageEnums.denemepersonicon.assetImage, fit: BoxFit.cover, color: ProjectColors.themeColorMOD2, height: 40, width: 40,),
                    ],
                  ),
                  Space.mWidth,
                  GestureDetector(
                      onTap: () {
                        authService.signOut();
                        //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context) => const SignPage(),), (route) => false);
                      },
                      child: Icon(Icons.logout, color: ProjectColors.themeColorMOD2, size: 25)),
                ],
              );
  }

  Row _terms() {
    return Row(
      children: [
        MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => termHover = true),
            onExit: (_) => setState(() => termHover = false),
            child: _term(
                'Term of Use',
                controller.termHover.value ? ProjectColors.customColor : ProjectColors.greyColor,
                () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Term(),
                    )))),
        Space.mWidth,
        MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => policyHover = true),
            onExit: (_) => setState(() => policyHover = false),
            child: _term(
                'Privacy Policy',
                controller.policyHover.value ? ProjectColors.customColor : ProjectColors.greyColor,
                () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const Policy(),
                    ),
                    (route) => false))),
        Space.mWidth,
        MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => subscriptionHover = true),
            onExit: (_) => setState(() => subscriptionHover = false),
            child: _term(
                'About Subscriptions',
                controller.subscriptionsHover.value ? ProjectColors.customColor : ProjectColors.greyColor,
                () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const Subscriptions(),
                    ),
                    (route) => false))),
      ],
    );
  }

  Widget _term(String text, Color color, Function todo) {
    return GestureDetector(onTap: () => todo(), child: ProjectText.rText(text: text, fontSize: 16, color: color));
  }
}
