import 'package:get/get.dart';

class Controller extends GetxController {
  var signState = 0.obs;
  var pageIndex = 0.obs;
  var countryCode = ''.obs;

  // User
  var userName = ''.obs;

  // MOBILE
  // *************
  // LOGIN
  // **********
  var signHover = false.obs;
  var forgotHover = false.obs;
  // SIGN IN
  // **********
  // MENU
  // **********
  var isMenuOpen = false.obs;
  var logoutHover = false.obs;

  // DESKTOP
  // **********
  // LOGIN
  // *********
  var loginHover = false.obs;
  var rememberPassLogin = false.obs;
  // SIGN IN
  // ********
  var rememberPassSignUp = false.obs;
  // BAR
  // ********
  var termHover = false.obs;
  var policyHover = false.obs;
  var subscriptionsHover = false.obs;
  var doorHover = false.obs;

  // DATE
  var startDate = DateTime.now().subtract(const Duration(days: 1)).obs;
  var endDate = DateTime.now().add(const Duration(days: 1)).obs;
}
