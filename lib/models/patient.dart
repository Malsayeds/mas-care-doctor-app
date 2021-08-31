class Patient {
  final int id;
  final String age;
  final String name;
  final String? image;
  final String? email;
  final String? gender;
  final String? phoneNumber;
  final String? diagnosis;
  final String? city;
  final String? area;

  Patient({
    required this.id,
    required this.age,
    required this.name,
    required this.image,
    required this.email,
    required this.gender,
    required this.phoneNumber,
    required this.diagnosis,
    required this.city,
    required this.area,
  });

  factory Patient.fromMap(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      age: json['age'],
      name: json['name'],
      image: json['image'],
      email: json['email'],
      gender: json['gender'],
      phoneNumber: json['contact_number'],
      diagnosis: json['diagnosis'],
      city: json['city'],
      area: json['area'],
    );
  }
}
