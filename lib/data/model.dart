class ECommerceModel {
  late final double id;
  late final String title;
  late final double price;
  late final String description;
  late final String image;
  late final Ratings ratings;

  ECommerceModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.ratings,
  });

  factory ECommerceModel.fromJson(Map<String, dynamic> json) {
    return ECommerceModel(
      id: (json["id"] as num).toDouble(),
      title: json["title"],
      price: (json["price"] as num).toDouble(),
      description: json["description"],
      image: json["image"],
      ratings: Ratings.fromJson(json["rating"]),
    );
  }
}

class Ratings {
  final double rate;
  final double count;

  Ratings({required this.rate, required this.count});

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      rate: (json["rate"] as num).toDouble(),
      count: (json["count"] as num).toDouble(),
    );
  }
}
