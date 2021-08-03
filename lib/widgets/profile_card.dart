import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;

  const ProfileCard({
    required this.title,
    required this.body,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 8.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: mainColor,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Spacer(),
              Text(
                body,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
