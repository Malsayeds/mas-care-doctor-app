import 'package:doctoworld_doctor/Auth/login_navigator.dart';
import 'package:doctoworld_doctor/BottomNavigation/Account/add_hospital.dart';
import 'package:doctoworld_doctor/BottomNavigation/Account/add_service.dart';
import 'package:doctoworld_doctor/BottomNavigation/Account/add_specialization.dart';
import 'package:doctoworld_doctor/BottomNavigation/Account/change_language_page.dart';
import 'package:doctoworld_doctor/BottomNavigation/Account/faq_page.dart';
import 'package:doctoworld_doctor/BottomNavigation/Account/profile_page.dart';
import 'package:doctoworld_doctor/BottomNavigation/Account/support_page.dart';
import 'package:doctoworld_doctor/BottomNavigation/Account/tnc.dart';
import 'package:doctoworld_doctor/BottomNavigation/Appointment/chat_page.dart';
import 'package:doctoworld_doctor/BottomNavigation/bottom_navigation.dart';
import 'package:flutter/material.dart';

class PageRoutes {
  static const String chatScreen = 'chat_screen';
  // static const String reviewsPage = 'reviews_page';
  static const String profilePage = 'profile_page';
  static const String supportPage = 'support_page';
  static const String faqPage = 'faq_page';
  static const String tncPage = 'tnc_page';
  static const String bottomNavigation = 'bottom_navigation';
  static const String addHospital = 'add_hospital';
  static const String addService = 'add_service';
  static const String addSpecialization = 'add_specialization';
  static const String languagePage = 'language_page';
  static const String loginNavigator = 'loginNavigator';

  Map<String, WidgetBuilder> routes() {
    return {
      chatScreen: (context) => ChatScreen(),
      // reviewsPage: (context) => ReviewPage(),
      profilePage: (context) => ProfilePage(),
      supportPage: (context) => SupportPage(),
      faqPage: (context) => FAQPage(),
      tncPage: (context) => TnCPage(),
      bottomNavigation: (context) => BottomNavigation(),
      addHospital: (context) => AddHospital(),
      addService: (context) => AddService(),
      addSpecialization: (context) => AddSpecialization(),
      languagePage: (context) => ChangeLanguagePage(),
      loginNavigator: (context) => LoginNavigator(),
    };
  }
}
