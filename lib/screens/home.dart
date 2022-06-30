import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/screens/screens.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    SizeConfig.getDevice();

    return Scaffold(
        backgroundColor: ProjectColors.opacityDEFb(0.94),
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) return Center(child: Image(image: ImageEnums.homelogo.assetImage, width: 60, height: 60, color: Colors.white));
              if (snapshot.hasData) {
                //final bool isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
                return const Monitor();
                //isVerified ? const Monitor() : const Verification();
              } else {
                return const Sign();
              }
            }));
  }
}


// @override
// void initState() {
//   ProjectInit.initializeRemoteConfig();
//   ProjectInit.getText();
//   configText = ProjectInit.parsedJson;
//   super.initState();
// }
