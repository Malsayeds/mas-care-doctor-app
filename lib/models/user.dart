class User {
  final String name;
  final String email;
  final String phone;
  final String? image;
  final double? fees;
  final double? experience;

  User({
    required this.name,
    required this.email,
    required this.phone,
    this.image,
    this.fees,
    this.experience,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        image: json['image'],
        fees: double.parse(json['fees'].toString()),
        experience: double.parse(json['experience'].toString()),
      );
}
