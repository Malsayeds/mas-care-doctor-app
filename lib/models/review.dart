class Review {
  final String username;
  final String? image;
  final int rate;
  final String review;
  final String date;

  Review({
    required this.username,
    this.image,
    required this.rate,
    required this.review,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        username: json['username'],
        image: json['image'],
        rate: json['rate'],
        review: json['review'],
        date: json['date'],
      );
}
