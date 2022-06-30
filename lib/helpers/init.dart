// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class ProjectInit {
  static var parsedJson;
  static var remoteConfig;

  static void initializeRemoteConfig() async {
    remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1), minimumFetchInterval: const Duration(minutes: 1)));
    await remoteConfig.fetchAndActivate();
  }

  static void getText() async {
    final messages = remoteConfig.getValue('messages').asString();
    parsedJson = jsonDecode(messages);
  }
}
