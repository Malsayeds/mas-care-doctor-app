import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/providers/auth.dart';
import 'package:doctoworld_doctor/providers/profile.dart';
import 'package:doctoworld_doctor/screens/Auth/Login/login_screen.dart';
import 'package:doctoworld_doctor/screens/splash_screen.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Locale/language_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeLanguagePage extends StatefulWidget {
  static const String ROUTE_NAME = 'language_page';

  @override
  _ChangeLanguagePageState createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  late LanguageCubit _languageCubit;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context, listen: false);
  }

  Future<void> getUserData() async {
    try {
      final apptData = Provider.of<Profile>(context, listen: false);
      await apptData.getProfileData();
    } catch (e) {
      SharedWidgets.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context);
    final List<String> _languages = [
      'English',
      'عربى',
    ];
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.changeLanguage),
          ),
          body: isLoading
              ? SharedWidgets.showLoader()
              : FadedSlideAnimation(
                  ListView.builder(
                    itemCount: _languages.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(_languages[index]),
                      onTap: () async {
                        try {
                          setState(() {
                            isLoading = true;
                          });
                          print(index);
                          if (index == 0) {
                            await authData.changeLanguage('en');
                            await _languageCubit.selectEngLanguage();
                          } else if (index == 1) {
                            await authData.changeLanguage('ar');
                            await _languageCubit.selectArabicLanguage();
                          } else {
                            await authData.changeLanguage('en');
                            await _languageCubit.selectEngLanguage();
                          }
                          await getUserData();
                          setState(() {
                            isLoading = false;
                          });
                        } catch (e) {
                          print(e);
                          SharedWidgets.showToast(
                            msg: INTERNET_WARNING_MESSAGE,
                            isError: true,
                          );
                          setState(() {
                            isLoading = false;
                          });
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
}
