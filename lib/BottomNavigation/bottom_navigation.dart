import 'package:doctoworld_doctor/BottomNavigation/Account/account_page.dart';
import 'package:doctoworld_doctor/BottomNavigation/Appointment/my_appointments.dart';
import 'package:doctoworld_doctor/BottomNavigation/Reviews/reviews_page.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
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
        items: items,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            start = size.width * index / items.length;
          });
        },
      ),
    );
  }
}
