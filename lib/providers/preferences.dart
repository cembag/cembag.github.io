import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider {
  static SharedPreferences? _sharedPreferences;

  PreferencesProvider() {
    SharedPreferences.getInstance().then((prefs) => _sharedPreferences = prefs);
  }

  static bool? get isViewed => _sharedPreferences!.getBool("onBoard");
}
