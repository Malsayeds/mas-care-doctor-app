import 'package:doctoworld_doctor/screens/Auth/Login/UI/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'keys.dart';

class Config {
  static Future<void> unAuthenticatedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(TOKEN_KEY);
    Keys.navKey.currentState
        ?.pushNamedAndRemoveUntil(LoginScreen.ROUTE, (route) => false);
  }
}
