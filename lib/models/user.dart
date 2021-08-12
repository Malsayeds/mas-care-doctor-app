class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? image;
  final String gender;
  final num? fees;
  final String? experience;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    this.image,
    this.fees,
    this.experience,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        gender: json['gender'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        image: json['image'],
        fees: json['fees'],
        experience: json['experience'],
      );
}
