import 'package:doctoworld_doctor/cubit/auth_cubit.dart';
import 'package:doctoworld_doctor/screens/Auth/Login/UI/login_screen.dart';
import 'package:doctoworld_doctor/utils/Theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'Account/account_page.dart';
import 'Appointment/my_appointments.dart';
import 'Reviews/reviews_page.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  double start = 0;
  final List<Widget> _children = [
    MyAppointmentsPage(),
    ReviewsPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
          icon: Icon(Icons.event_available), label: locale.appointments),
      BottomNavigationBarItem(
          icon: Icon(Icons.thumbs_up_down), label: locale.reviews),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: locale.account),
    ];
    var size = MediaQuery.of(context).size;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          LoginScreen.ROUTE,
          (route) => false,
        );
      },
      child: Scaffold(
        body: Stack(
          children: [
            _children[_currentIndex],
            AnimatedPositionedDirectional(
              bottom: 0,
              start: start,
              child: Container(
                color: Theme.of(context).primaryColor,
                height: 2,
                width: size.width / 3,
              ),
              duration: Duration(milliseconds: 200),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          currentIndex: _currentIndex,
          selectedItemColor: primaryColor,
          items: items,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              start = size.width * index / items.length;
            });
          },
        ),
      ),
    );
  }
}
