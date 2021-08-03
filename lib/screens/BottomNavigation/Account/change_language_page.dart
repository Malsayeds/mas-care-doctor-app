import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/screens/Auth/Login/UI/login_screen.dart';
import '../../../Locale/language_cubit.dart';
import '../../../Locale/locale.dart';
import '../../../utils/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeLanguagePage extends StatefulWidget {
  @override
  _ChangeLanguagePageState createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  late LanguageCubit _languageCubit;
  int? _selectedLanguage = -1;

  @override
  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _languages = [
      'English',
      'عربى',
    ];
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        _selectedLanguage = getCurrentLanguage(locale);
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.changeLanguage!),
          ),
          body: FadedSlideAnimation(
            ListView.builder(
              itemCount: _languages.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_languages[index]),
                onTap: () {
                  setState(() {
                    _selectedLanguage = index;
                    Navigator.pushNamed(context, LoginScreen.ROUTE);
                  });
                  if (_selectedLanguage == 0) {
                    _languageCubit.selectEngLanguage();
                  } else if (_selectedLanguage == 1) {
                    _languageCubit.selectArabicLanguage();
                  }
                },
              ),
            ),
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          ),
        );
      },
    );
  }

  int getCurrentLanguage(Locale locale) {
    if (locale == Locale('en'))
      return 0;
    else if (locale == Locale('ar'))
      return 1;
    else if (locale == Locale('fr'))
      return 2;
    else if (locale == Locale('id'))
      return 3;
    else if (locale == Locale('pt'))
      return 4;
    else if (locale == Locale('es'))
      return 5;
    else if (locale == Locale('it'))
      return 6;
    else if (locale == Locale('tr'))
      return 7;
    else if (locale == Locale('sw'))
      return 8;
    else
      return -1;
  }
}
