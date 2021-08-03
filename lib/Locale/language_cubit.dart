import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(Locale('en'));

  Locale? locale;

  Future<void> selectEngLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(LOCALE_KEY, 'en');
    print('selectArabicLanguage: en');
    emit(Locale('en'));
  }

  Future<void> selectArabicLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(LOCALE_KEY, 'ar');
    print('selectArabicLanguage: ar');
    emit(Locale('ar'));
  }

  void setLocale(String localeCode) {
    print('setLocale: $localeCode');
    emit(Locale(localeCode));
  }
}
