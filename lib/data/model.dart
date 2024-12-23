class ECommerceModel {
  late final String id;
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
      id: json["id"],
      title: json["title"],
      price: json["price"],
      description: json["description"],
      image: json["image"],
      ratings: Ratings.fromJson(json["rating"]),
    );
  }
}

class Ratings {
  final double rate;
  final int count;

  Ratings({required this.rate, required this.count});

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      rate: json["rate"],
      count: json["count"],
    );
  }
}
