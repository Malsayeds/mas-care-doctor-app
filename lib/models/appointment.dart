class Appointment {
  final String patientName;
  final String time;
  final String date;
  String? image;
  String? diagnosis;
  String? createdAt;

  Appointment({
    required this.patientName,
    this.image,
    required this.time,
    required this.date,
    this.diagnosis,
    this.createdAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        patientName: json['patient_name'],
        image: json['image'],
        time: json['time'],
        date: json['date'],
        diagnosis: json['diagnosis'],
        createdAt: json['created_at'],
      );
}
