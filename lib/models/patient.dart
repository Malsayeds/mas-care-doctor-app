class Patient {
  final int id;
  final int? age;
  final String? name;
  final String? image;
  final String? email;
  final String? gender;
  final String? phoneNumber;
  final String? diagnosis;

  Patient({
    required this.id,
    required this.age,
    required this.name,
    required this.image,
    required this.email,
    required this.gender,
    required this.phoneNumber,
    required this.diagnosis,
  });

  factory Patient.fromMap(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      age: json['age'],
      name: json['user']['name'],
      image: json['user']['image'],
      email: json['user']['email'],
      gender: json['user']['gender'],
      phoneNumber: json['contact_number'],
      diagnosis: json['diagnosis'],
    );
  }
}
