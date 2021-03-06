import 'package:doctoworld_doctor/screens/Auth/Login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'keys.dart';

class Config {
  static Future<void> unAuthenticateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Keys.navKey.currentState
        ?.pushNamedAndRemoveUntil(LoginScreen.ROUTE, (route) => false);
  }
}
