import 'package:flutter/material.dart';

class Availability {
  bool isChecked;
  String day;
  TimeOfDay from;
  TimeOfDay to;

  Availability({
    required this.isChecked,
    required this.day,
    required this.from,
    required this.to,
  });

  @override
  String toString() => 'Data(day: $day, from: $from, to: $to)';

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        day: json['day'],
        from: json['from'],
        to: json['to'],
        isChecked: true,
      );
}
