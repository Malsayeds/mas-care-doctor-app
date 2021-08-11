class Specification {
  final int id;
  final String name;
  bool isChecked;

  Specification({
    required this.id,
    required this.name,
    required this.isChecked,
  });

  factory Specification.fromJson(Map<String, dynamic> json) => Specification(
        id: json['id'],
        name: json['name'],
        isChecked: json['is_checked'],
      );
}
