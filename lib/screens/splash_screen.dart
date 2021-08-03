import 'package:doctoworld_doctor/Locale/language_cubit.dart';
import 'package:doctoworld_doctor/screens/Auth/Login/UI/login_screen.dart';
import 'package:doctoworld_doctor/screens/BottomNavigation/Account/change_language_page.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
        final langData = BlocProvider.of<LanguageCubit>(context);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? localeCode = prefs.getString(LOCALE_KEY);
        if (localeCode != null && (localeCode == 'en' || localeCode == 'ar')) {
          langData.setLocale(localeCode);
          Navigator.of(context).pushReplacementNamed(LoginScreen.ROUTE);
        } else {
          Navigator.of(context).pushReplacementNamed(ChangeLanguagePage.ROUTE_NAME);
        }
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