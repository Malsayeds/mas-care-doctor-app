class Service {
  final int id;
  final String name;
  bool isChecked;

  Service({
    required this.id,
    required this.name,
    required this.isChecked,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json['id'],
        name: json['name'],
        isChecked: json['is_checked'],
      );
}
