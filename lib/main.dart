import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/models/utils.dart';
import 'package:weloggerweb/screens/home.dart';
import 'package:weloggerweb/services/services.dart';
import 'providers/providers.dart';

bool? isViewed;
dynamic parsedJson;

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  String? value = CookieManager.getCookie('isviewed');
  isViewed = value == null ? false : true;
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBK0OWp03Vq3TuD5buwPkqPspeM2khLJs0",
      authDomain: "wseen-3f337.firebaseapp.com",
      projectId: "wseen-3f337",
      storageBucket: "wseen-3f337.appspot.com",
      messagingSenderId: "208179421998",
      appId: "1:208179421998:web:745bd28c6c226770cd50bf",
      measurementId: "G-DC1TVJHPDL"),
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent));

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => ModelProvider()),
    ChangeNotifierProvider(create: (context) => MouseProvider()),
    ChangeNotifierProvider(create: (context) => FieldProvider()),
  ], child: const WeloggerWEB()));
}

class WeloggerWEB extends StatefulWidget {
  
  const WeloggerWEB({Key? key}) : super(key: key);

  @override
  State<WeloggerWEB> createState() => _WeloggerWEBState();
}

class _WeloggerWEBState extends State<WeloggerWEB> {

  Map? cookieMap;
  bool? isLogin;

  String email = '';
  String password = '';

  @override
  void initState() {
    print(CookieManager.getCookieAsMap());
    _getUserCookies();
    _initializeRemoteConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown}),
        scaffoldMessengerKey: Utils.messengerKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 15, 15, 15),
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 15, 15, 15),
          brightness: Brightness.light,
        ),
        home: parsedJson == null 
        ? const Center(child: CircularProgressIndicator(color: Colors.orange))
        : isViewed! ? const HomePage() : const MobileOnboardOne());
  }
  
  Future<void> _initializeRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(minutes: 1),
    ));
    await remoteConfig.fetchAndActivate();
    final messages = remoteConfig.getValue('messages').asString();
    parsedJson = jsonDecode(messages);
    setState(() {
      
    });
  }

  _getUserCookies(){
    cookieMap = CookieManager.getCookieAsMap();
    isLogin = stringToBoolean(cookieMap!['login'] ?? '');
    if(isLogin!){
      email = cookieMap!['email'];
      password = cookieMap!['password'];
      FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    }
  }

  stringToBoolean(String string){
    switch(string.toLowerCase().trim()){
        case "true": 
        case "yes": 
        case "1": 
          return true;
        case "false": 
        case "no": 
        case "0": 
        case '': 
          return false;
        default: 
          return false;
    }
  }

  

}



