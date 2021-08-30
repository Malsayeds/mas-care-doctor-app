import 'package:flutter/material.dart';

class AppointmentDetails extends StatelessWidget {
  static const String ROUTE_NAME = '/appointmentDetails';
  const AppointmentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
