class Specialization {
  final int id;
  final String name;
  bool isChecked;

  Specialization({
    required this.id,
    required this.name,
    required this.isChecked,
  });

  factory Specialization.fromJson(Map<String, dynamic> json) => Specialization(
        id: json['id'],
        name: json['name'],
        isChecked: json['is_checked'],
      );
}
