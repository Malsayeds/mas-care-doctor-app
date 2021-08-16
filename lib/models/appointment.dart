class Appointment {
  final int id;
  int status;
  final String patientName;
  final String? phone;
  final String time;
  final String date;
  String? image;
  String? diagnosis;
  String? createdAt;

  // 0 Pending
  // 1 Approved
  // 2 Rejected

  Appointment({
    required this.id,
    required this.status,
    required this.patientName,
    required this.time,
    required this.date,
    this.phone,
    this.image,
    this.diagnosis,
    this.createdAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json['id'],
        phone: json['phone'],
        status: json['status'],
        patientName: json['patient_name'],
        image: json['image'],
        time: json['time'],
        date: json['date'],
        diagnosis: json['diagnosis'],
        createdAt: json['created_at'],
      );
}
