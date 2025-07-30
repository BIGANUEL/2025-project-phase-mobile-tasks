import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
class Product extends Equatable{
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  @override
  List<Object> get props => [id, name, description, price, imageUrl];

  Product copywith({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
    );
  }
}
