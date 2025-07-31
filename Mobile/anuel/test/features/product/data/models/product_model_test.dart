import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:anuel/features/product/data/models/product_model.dart';
import 'package:anuel/features/product/domain/entities/product.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tProductModel = ProductModel(
    id: 1,
    name: 'Test Product',
    description: 'This is a test product',
    price: 99.99,
    imageUrl: 'https://example.com/image.png',
  );

  group('fromJson', () {
    test('should return a valid model when the JSON is correct', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('product.json'));

      // act
      final result = ProductModel.fromJson(jsonMap);

      // assert
      expect(result, tProductModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () {
      // act
      final result = tProductModel.toJson();

      // assert
      final expectedMap = {
        "id": 1,
        "name": "Test Product",
        "description": "This is a test product",
        "price": 99.99,
        "imageUrl": "https://example.com/image.png"
      };

      expect(result, expectedMap);
    });
  });
}
