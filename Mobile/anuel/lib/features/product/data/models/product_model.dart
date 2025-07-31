import 'package:anuel/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required int id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
  }) : super(
         id: id,
         name: name,
         description: description,
         price: price,
         imageUrl: imageUrl,
       );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'imageUrl': imageUrl,
  };
}
