import 'package:doctoworld_doctor/providers/auth.dart';
import 'package:doctoworld_doctor/providers/reviews.dart';
import 'package:doctoworld_doctor/screens/splash_screen.dart';
import 'package:doctoworld_doctor/utils/bloc_observer.dart';
import 'package:doctoworld_doctor/utils/keys.dart';
import 'package:doctoworld_doctor/utils/providers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'providers/appointments.dart';
import 'providers/profile.dart';
import 'utils/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Locale/language_cubit.dart';
import 'utils/Routes/routes.dart';
import 'utils/Theme/style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: transparentColor),
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(DoctoWorldDoctor());
}

class DoctoWorldDoctor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<Auth>(
            create: (context) => Auth(),
          ),
          ChangeNotifierProvider<Profile>(
            create: (context) => Profile(),
          ),
          ChangeNotifierProvider<Appointments>(
            create: (context) => Appointments(),
          ),
          ChangeNotifierProvider<Reviews>(
            create: (context) => Reviews(),
          ),
        ],
        child: BlocBuilder<LanguageCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp(
              navigatorKey: Keys.navKey,
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
      ),
    );
  }
}
