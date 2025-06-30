class ProductResModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rate rating;

  ProductResModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductResModel.fromjson(Map<String, dynamic> map) {
    return ProductResModel(
      id: map['id'] as int,
      title: map['title'] as String,
      price: (map['price'] as num).toDouble(),
      description: map['description'] as String,
      category: map['category'] as String,
      image: map['image'] as String,
      rating: Rate.fromjson(map['rating']),
    );
  }
}

class Rate {
  final dynamic rate;
  final int count;

  Rate({required this.rate, required this.count});

  factory Rate.fromjson(Map<String, dynamic> map) {
    return Rate(
      rate: (map['rate'] as num).toDouble(),
      count: map['count'] as int,
    );
  }
}
