import 'package:doctoworld_doctor/screens/BottomNavigation/Account/change_language_page.dart';

import 'utils/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'Locale/language_cubit.dart';
import 'Locale/locale.dart';
import 'utils/Routes/routes.dart';
import 'utils/Theme/style.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: transparentColor));
  runApp(Phoenix(child: DoctoWorldDoctor()));
}

class DoctoWorldDoctor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageCubit>(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (_, locale) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              const AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en'),
              const Locale('ar'),
            ],
            locale: locale,
            theme: lightTheme,
            home: ChangeLanguagePage(),
            routes: PageRoutes().routes(),
          );
        },
      ),
    );
  }
}
