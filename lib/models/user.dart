class User {
  final String name;
  final String email;
  final String phone;
  final String? image;
  final double? fees;
  final double? experience;
  final double? consultationFees;
  final String bio;
  final String qualification;
  final String address;
  final String about;
  final String title;
  final int views;
  final int canApproveCoupon;
  final int canCheckupHome;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.fees,
    required this.experience,
    required this.about,
    required this.address,
    required this.bio,
    required this.title,
    required this.views,
    required this.qualification,
    required this.consultationFees,
    required this.canApproveCoupon,
    required this.canCheckupHome,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'],
      fees: double.tryParse(json['fees'].toString()),
      experience: double.tryParse(json['experience'].toString()),
      about: json['about'],
      address: json['detailed_address'],
      bio: json['bio'],
      views: json['views'],
      title: json['title'],
      qualification: json['qualification'],
      consultationFees: double.tryParse(json['consultation_fees'].toString()),
      canApproveCoupon: json['approved_coupons'],
      canCheckupHome: json['inhome_checkup']);
}
