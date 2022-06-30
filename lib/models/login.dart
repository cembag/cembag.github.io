import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weloggerweb/globalvalues/globalvalues.dart';
import 'package:weloggerweb/models/loading.dart';
import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/models/utils.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/providers/providers.dart';
import 'package:weloggerweb/screens/screens.dart';
import 'package:weloggerweb/services/auth.dart';
import 'package:weloggerweb/services/cookie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginsignState();
}

class _LoginsignState extends State<LoginPage> {
  ModelProvider? modelProvider;
  MouseProvider? mouseProvider;
  final formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  final TextEditingController usernameEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _login(context);
  }

  Widget _login(BuildContext context) {
    modelProvider = Provider.of<ModelProvider>(context);
    mouseProvider = Provider.of<MouseProvider>(context);
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return Container(
        padding: const EdgeInsets.all(20),
        width: SizeConfig.isDesktop! ? SizeConfig.screenWidth! - Values.desktopMenuWidth : SizeConfig.screenWidth,
        height: SizeConfig.screenHeight! - Values.barHeight,
        child: _body(context));
  }

  Widget _body(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
          _welcomeText(context),
          Space.mHeight,
          Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  width: SizeConfig.isMobile! ? Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
                  child: TextFormField(
                    validator: (email) => email != null && EmailValidator.validate(email) ? null : 'Enter a valid email',
                    controller: usernameEmailController,
                    style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
                    decoration: _inputDecoration('Email'),
                  ),
                ),
                Space.sHeight,
                SizedBox(
                  width: SizeConfig.isMobile! ? Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
                  child: TextFormField(
                      controller: passwordController,
                      style: TextStyle(color: ProjectColors.customColor, fontSize: 16),
                      decoration: _inputDecoration('Password')),
                ),
              ],
            ),
          ),
          Space.sHeight,
          _rememberForgot(context),
          Space.mHeight,
          _signInButton(context),
          Space.mHeight,
          _doesntHaveAccount(context),
        ]),
      ),
    );
  }

  InputDecoration _inputDecoration(String text) {
    return InputDecoration(
        contentPadding: ProjectPadding.horizontalPadding(value: 10),
        hintText: text,
        hintStyle: TextStyle(color: ProjectColors.greyColor, fontSize: 14),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ProjectColors.greyColor, width: 1),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ProjectColors.customColor, width: 1),
        ));
  }

  Widget _forgotPass(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Forgot())),
        child: ProjectText.rText(
            text: 'Forgot Password',
            fontSize: Values.xSValue,
            color: Colors.blue,
            decoration: controller.forgotHover.value ? TextDecoration.underline : TextDecoration.none));
  }

  Widget _doesntHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProjectText.rText(text: 'Does not have an account? ', fontSize: Values.xSValue, color: Colors.grey),
        GestureDetector(
            onTap: () => modelProvider!.toggleSignState(),
            child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => mouseProvider!.toggleDoestHaveAccount(),
                onExit: (_) => mouseProvider!.toggleDoestHaveAccount(),
                child: ProjectText.rText(
                  text: 'Sign Up',
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
        ProjectText.rText(text: 'login and start to track', fontSize: Values.bigValue, color: ProjectColors.greyColor),
      ],
    );
  }

  Widget _signInButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final isValid = formKey.currentState!.validate();
        if (!isValid) return;
        String email = usernameEmailController.text;
        String password = passwordController.text;
        showDialog(context: context,builder: (BuildContext context) => const Loading());
        authService.signIn(email, password).whenComplete(() => Navigator.popUntil(context, (route) => route.isFirst)).catchError((error, stackTrace) {
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
                text: 'Sign In',
                fontSize: Values.fitValue,
                color: mouseProvider!.loginHover ? ProjectColors.customColor : ProjectColors.greyColor),
          ),
        ),
      ),
    );
  }

  Widget _rememberForgot(BuildContext context) {
    return SizedBox(
      height: 20,
      width: SizeConfig.isMobile! ? Values.mobileInputFieldWidth : Values.desktopInputFieldWidth,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _forgotPass(context),
        _rememberPassLogin(context),
      ]),
    );
  }

  Widget _rememberPassLogin(BuildContext context) {
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
    usernameEmailController.clear();
    passwordController.clear();
  }
}
