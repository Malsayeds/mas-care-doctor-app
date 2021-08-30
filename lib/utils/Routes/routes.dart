import 'package:doctoworld_doctor/screens/Auth/Login/UI/login_screen.dart';
import 'package:doctoworld_doctor/screens/Auth/Registration/UI/registration_screen.dart';
import 'package:doctoworld_doctor/screens/Auth/Verification/UI/verification_screen.dart';
import 'package:doctoworld_doctor/screens/BottomNavigation/Account/add_hospital.dart';
import 'package:doctoworld_doctor/screens/BottomNavigation/Account/add_service.dart';
import 'package:doctoworld_doctor/screens/BottomNavigation/Account/add_specialization.dart';
import 'package:doctoworld_doctor/screens/BottomNavigation/Account/change_language_page.dart';
import 'package:doctoworld_doctor/screens/BottomNavigation/Account/faq_page.dart';
import 'package:doctoworld_doctor/screens/BottomNavigation/Account/profile_page.dart';
import 'package:doctoworld_doctor/screens/BottomNavigation/Account/support_page.dart';
import 'package:doctoworld_doctor/screens/BottomNavigation/Account/tnc.dart';
import 'package:doctoworld_doctor/screens/BottomNavigation/Appointment/appointment_details.dart';
import 'package:doctoworld_doctor/screens/BottomNavigation/Appointment/chat_page.dart';
import 'package:doctoworld_doctor/screens/BottomNavigation/bottom_navigation.dart';
import 'package:flutter/material.dart';

class PageRoutes {
  // static const String reviewsPage = 'reviews_page';
  static const String supportPage = 'support_page';
  static const String faqPage = 'faq_page';
  static const String tncPage = 'tnc_page';
  static const String bottomNavigation = 'bottom_navigation';
  static const String addHospital = 'add_hospital';
  static const String addService = 'add_service';
  static const String addSpecialization = 'add_specialization';

  static Map<String, WidgetBuilder> routes() {
    return {
      ChatScreen.ROUTE_NAME: (context) => ChatScreen(),
      // reviewsPage: (context) => ReviewPage(),
      ProfilePage.ROUTE_NAME: (context) => ProfilePage(),
      supportPage: (context) => SupportPage(),
      faqPage: (context) => FAQPage(),
      tncPage: (context) => TnCPage(),
      bottomNavigation: (context) => BottomNavigation(),
      addHospital: (context) => AddHospital(),
      addService: (context) => AddService(),
      addSpecialization: (context) => AddSpecialization(),
      ChangeLanguagePage.ROUTE_NAME: (context) => ChangeLanguagePage(),
      LoginScreen.ROUTE: (context) => LoginScreen(),
      RegistrationScreen.ROUTE: (context) => RegistrationScreen(),
      VerificationScreen.ROUTE: (context) => VerificationScreen(),
      AppointmentDetails.ROUTE_NAME: (context) => AppointmentDetails(),
    };
  }
}
