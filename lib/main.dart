import 'package:doctoworld_doctor/screens/BottomNavigation/Account/change_language_page.dart';
import 'package:doctoworld_doctor/screens/splash_screen.dart';
import 'package:doctoworld_doctor/utils/bloc_observer.dart';
import 'package:doctoworld_doctor/utils/providers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'utils/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'Locale/language_cubit.dart';
import 'utils/Routes/routes.dart';
import 'utils/Theme/style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: transparentColor));
  Bloc.observer = SimpleBlocObserver();
  runApp(Phoenix(child: DoctoWorldDoctor()));
}

class DoctoWorldDoctor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              AppLocalizations.delegate,
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
            home: SplashScreen(),
            routes: PageRoutes.routes(),
          );
        },
      ),
    );
  }
}
