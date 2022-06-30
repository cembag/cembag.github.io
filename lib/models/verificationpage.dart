import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:weloggerweb/models/utils.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/screens/screens.dart';
import 'package:weloggerweb/services/auth.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  bool isVerified = false;
  bool resendEmail = false;
  Timer? timer;
  final AuthService authService = AuthService();

  @override
  void initState() {
    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(const Duration(seconds: 3), (timer) => checkEmailVerified());
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return isVerified
        ? const Monitor()
        : SizedBox(
            width: SizeConfig.isDesktop! ? SizeConfig.screenWidth! - Values.desktopMenuWidth : SizeConfig.screenWidth,
            height: SizeConfig.screenHeight! - Values.barHeight,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [text, Space.mHeight, resendEmail ? button() : Space.emptySpace, Space.sHeight, cancel()]),
          );
  }

  Widget cancel() => RichText(
      text: TextSpan(
          text: 'Cancel',
          style: TextStyle(color: ProjectColors.offlineColor, fontSize: 20),
          recognizer: TapGestureRecognizer()..onTap = () => authService.signOut()));

  Widget button() {
    return GestureDetector(
      onTap: () => sendVerificationEmail(),
      child: Container(
        width: Values.mobileInputFieldWidth,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: ProjectColors.greyColor, width: 1)),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.email,
              color: Colors.grey,
              size: 20,
            ),
            Space.sWidth,
            Text(
              'Resend Email',
              style: TextStyle(color: ProjectColors.greyColor, fontSize: 16),
            ),
          ],
        )),
      ),
    );
  }

  Widget get text => const Text('Verification sent your email.',
      textAlign: TextAlign.center, style: TextStyle(color: Color.fromARGB(255, 230, 230, 230), fontSize: 24));

  sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      setState(() => resendEmail = false);
      if (mounted) return;
      await Future.delayed(const Duration(seconds: 5));
      setState(() => resendEmail = true);
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isVerified) {
      timer?.cancel();
      setState(() {});
    }
  }
}
