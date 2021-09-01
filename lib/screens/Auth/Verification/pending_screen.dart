import 'package:doctoworld_doctor/providers/auth.dart';
import 'package:doctoworld_doctor/utils/Routes/routes.dart';
import 'package:doctoworld_doctor/utils/Theme/colors.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PendingScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/pendingScreen';

  const PendingScreen({Key? key}) : super(key: key);

  @override
  _PendingScreenState createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context);
    return Scaffold(
      backgroundColor: secondaryBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Status: ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                        text: authData.status,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                authData.message ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
