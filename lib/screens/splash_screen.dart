import 'package:doctoworld_doctor/Locale/language_cubit.dart';
import 'package:doctoworld_doctor/screens/Auth/Login/login_screen.dart';
import 'package:doctoworld_doctor/screens/Auth/Verification/identity_screen.dart';
import 'package:doctoworld_doctor/screens/BottomNavigation/Account/change_language_page.dart';
import 'package:doctoworld_doctor/utils/Routes/routes.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String ROUTE_NAME = '/splashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () async {
        final langData = BlocProvider.of<LanguageCubit>(context, listen: false);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? localeCode = prefs.getString(LOCALE_KEY);
        langData.setLocale(localeCode ?? 'en');
        Navigator.of(context).pushReplacementNamed(IdentityScreen.ROUTE_NAME);
        // if (prefs.getString(TOKEN_KEY) != null) {
        //   Navigator.of(context)
        //       .pushReplacementNamed(PageRoutes.bottomNavigation);
        // } else {
        //   Navigator.of(context).pushReplacementNamed(LoginScreen.ROUTE);
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator.adaptive(),
            SizedBox(
              height: 16,
            ),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
