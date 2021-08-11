class Rate {
  final int rate;
  final int rateCount;

  Rate({
    required this.rate,
    required this.rateCount,
  });

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        rate: json['rate'],
        rateCount: json['rate_count'],
      );
}
