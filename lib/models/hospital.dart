import 'package:doctoworld_doctor/screens/BottomNavigation/Account/add_hospital.dart';

class Hospital {
  final String title;
  final String subtitle;
  bool isChecked;

  Hospital({
    required this.title,
    required this.subtitle,
    this.isChecked = false,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
        title: json['title'],
        subtitle: json['subtitle'],
        isChecked: json['is_checked'] == null ? false : json['name'],
      );
}
