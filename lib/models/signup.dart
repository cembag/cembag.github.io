import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weloggerweb/models/loading.dart';
import 'package:weloggerweb/models/utils.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/providers/providers.dart';
import 'package:weloggerweb/services/services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpsignState();
}

class _SignUpsignState extends State<SignUpPage> {
  MouseProvider? mouseProvider;
  ModelProvider? modelProvider;
  final formkey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    modelProvider = Provider.of<ModelProvider>(context);
    mouseProvider = Provider.of<MouseProvider>(context);
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return Container(
      padding: const EdgeInsets.all(20),
      width: SizeConfig.isDesktop! ? SizeConfig.screenWidth! - Values.desktopMenuWidth : SizeConfig.screenWidth,
      height: SizeConfig.screenHeight! - Values.barHeight,
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
            _welcomeText(context),
            Space.mHeight,
            SizedBox(
              width: SizeConfig.isMobile! ? Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
              child: TextFormField(
                controller: nameController,
                style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
                decoration: _inputDecoration('Username'),
              ),
            ),
            Space.sHeight,
            SizedBox(
              width: SizeConfig.isMobile! ? Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
              child: TextFormField(
                validator: (email) => email != null && EmailValidator.validate(email) ? null : 'Enter a valid email',
                controller: emailController,
                style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
                decoration: _inputDecoration('Email'),
              ),
            ),
            Space.sHeight,
            SizedBox(
              width: SizeConfig.isMobile! ? Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
              child: TextFormField(
                  controller: passwordController,
                  validator: (password) => password!.length <= 6 ? 'Password ' : null,
                  style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
                  decoration: _inputDecoration('Password')),
            ),
            Space.sHeight,
            _rememberForgot(context),
            Space.mHeight,
            _signButton(context),
            Space.mHeight,
            _doesntHaveAccount(context),
          ]),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
        contentPadding: ProjectPadding.horizontalPadding(value: 10),
        hintText: hintText,
        hintStyle: TextStyle(color: ProjectColors.greyColor, fontSize: 14),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ProjectColors.greyColor, width: 1),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ProjectColors.customColor, width: 1),
        ));
  }

  Widget _doesntHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProjectText.rText(text: 'Have an account? ', fontSize: Values.xSValue, color: Colors.grey),
        GestureDetector(
            onTap: () => modelProvider!.toggleSignState(),
            child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => mouseProvider!.toggleDoestHaveAccount(),
                onExit: (_) => mouseProvider!.toggleDoestHaveAccount(),
                child: ProjectText.rText(
                  text: 'Sign In',
                  fontSize: Values.xSValue,
                  color: Colors.blue,
                  decoration: mouseProvider!.doesntHaveAccount ? TextDecoration.underline : TextDecoration.none,
                ))),
      ],
    );
  }

  Widget _welcomeText(BuildContext context) {
    return Column(
      children: [
        ProjectText.rText(text: 'welogger', fontSize: 35, color: ProjectColors.customColor, fontWeight: FontWeight.bold),
        Space.mHeight,
        ProjectText.rText(text: 'sign up and start to track', fontSize: Values.bigValue, color: ProjectColors.greyColor),
      ],
    );
  }

  Widget _signButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final isValid = formkey.currentState!.validate();
        if (!isValid) return;
        String name = nameController.text;
        String email = emailController.text;
        String password = passwordController.text;
        showDialog(context: context,builder: (BuildContext context) => const Loading());
        authService.signUp(name, email, password).whenComplete(() => Navigator.of(context).popUntil((route) => route.isFirst)).catchError((error, stackTrace){
          final String errorMessage = error.toString();
          Utils.showSnackBar(errorMessage.substring(errorMessage.indexOf(']') + 2, errorMessage.length));
        }).then((value) => value != null ? CookieManager.updateUserCookie(isLogin: true, email: email, password: password) : null);
        clear();
      },
      child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => mouseProvider!.toggleLoginHover(),
          onExit: (_) => mouseProvider!.toggleLoginHover(),
          child: Container(
            width: SizeConfig.isMobile! ? Values.mobileSignButtonWidth : Values.desktopSignButtonWidth,
            height: SizeConfig.isMobile! ? Values.mobileSignButtonHeight : Values.desktopSignButtonHeight,
            decoration: BoxDecoration(
                color: ProjectColors.transparent,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                    color: mouseProvider!.loginHover ? ProjectColors.customColor : ProjectColors.greyColor, width: 1)),
            child: Center(
              child: ProjectText.rText(
                  text: 'Sign Up',
                  fontSize: Values.fitValue,
                  color: mouseProvider!.loginHover ? ProjectColors.customColor : ProjectColors.greyColor),
            ),
          )),
    );
  }

  Widget _rememberForgot(BuildContext context) {
    return SizedBox(
      height: 20,
      width: SizeConfig.isMobile! ? Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Space.emptySpace,
        _rememberPassSignUp(context),
      ]),
    );
  }

  Widget _rememberPassSignUp(BuildContext context) {
    return GestureDetector(
        onTap: () => mouseProvider!.toggleRememberPass(),
        child: Row(
          children: [
            ProjectText.rText(text: 'Remember me', fontSize: Values.xSValue, color: ProjectColors.greyColor),
            Space.xSWidth,
            Container(
                height: 15,
                width: 15,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: ProjectColors.customColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: ProjectColors.themeColorMOD2, width: 1)),
                child: Container(
                  decoration: BoxDecoration(
                      color: mouseProvider!.rememberPass ? Colors.green : ProjectColors.transparent,
                      shape: BoxShape.circle),
                )),
          ],
        ));
  }

  clear() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }
}
