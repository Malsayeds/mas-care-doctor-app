class User {
  final String firstName;
  final String? lastName;
  final String email;
  final String phone;
  final String? image;
  final num? fees;
  final String? experience;

  User({
    required this.firstName,
    this.lastName,
    required this.email,
    required this.phone,
    this.image,
    this.fees,
    this.experience,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        phone: json['phone'],
        image: json['image'],
        fees: json['fees'],
        experience: json['experience'],
      );
}
