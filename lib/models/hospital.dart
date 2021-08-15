class Hospital {
  final int id;
  final String name;
  bool isChecked;

  Hospital({
    required this.id,
    required this.name,
    this.isChecked = false,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
        id: json['id'],
        name: json['name'],
        isChecked: json['is_checked'] == null ? false : json['is_checked'],
      );
}
