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

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      day: json['day'],
      from: TimeOfDay(
        hour: int.parse(json['from'].split(":")[0]),
        minute: int.parse(json['from'].split(":")[1]),
      ),
      to: TimeOfDay(
        hour: int.parse(json['to'].split(":")[0]),
        minute: int.parse(json['to'].split(":")[1]),
      ),
      isChecked: true,
    );
  }
}
