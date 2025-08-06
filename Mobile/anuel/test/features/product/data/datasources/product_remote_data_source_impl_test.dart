import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:anuel/features/product/data/datasources/product_remote_data_source_impl.dart';
import 'package:anuel/features/product/data/models/product_model.dart';
import 'package:anuel/core/error/exception.dart';

void main() {
  late ProductRemoteDataSourceImpl remoteDataSource;

  final testProduct = ProductModel(
    id: 1,
    name: 'Laptop',
    price: 1200.0,
    description: 'Electronics',
    imageUrl: 'https://example.com/laptop.jpg',
  );

  group('ProductRemoteDataSourceImpl', () {
    test('should create product successfully', () async {
      final mockClient = MockClient((request) async {
        expect(request.method, 'POST');
        return http.Response('', 201);
      });

      remoteDataSource = ProductRemoteDataSourceImpl(mockClient);

      await remoteDataSource.createProduct(testProduct);
    });

    test('should fetch all products', () async {
      final mockClient = MockClient((request) async {
        return http.Response(json.encode([
          {
            "id": 1,
            "name": "Phone",
            "price": 999.0,
            "description": "Mobile",
            "imageUrl": "https://example.com/phone.jpg"
          },
          {
            "id": 2,
            "name": "Tablet",
            "price": 799.0,
            "description": "Gadget",
            "imageUrl": "https://example.com/tablet.jpg"
          }
        ]), 200);
      });

      remoteDataSource = ProductRemoteDataSourceImpl(mockClient);

      final result = await remoteDataSource.getAllProducts();

      expect(result.length, 2);
      expect(result[0].name, "Phone");
    });

    test('should fetch product by id', () async {
      final mockClient = MockClient((request) async {
        return http.Response(json.encode({
          "id": 1,
          "name": "Mouse",
          "price": 49.0,
          "description": "Peripheral",
          "imageUrl": "https://example.com/mouse.jpg"
        }), 200);
      });

      remoteDataSource = ProductRemoteDataSourceImpl(mockClient);

      final result = await remoteDataSource.getProductById(1);

      expect(result.name, "Mouse");
    });

    test('should update product', () async {
      final mockClient = MockClient((request) async {
        expect(request.method, 'PUT');
        return http.Response('', 200);
      });

      remoteDataSource = ProductRemoteDataSourceImpl(mockClient);

      await remoteDataSource.updateProduct(testProduct);
    });

    test('should delete product', () async {
      final mockClient = MockClient((request) async {
        expect(request.method, 'DELETE');
        return http.Response('', 204);
      });

      remoteDataSource = ProductRemoteDataSourceImpl(mockClient);

      await remoteDataSource.deleteProduct(1);
    });

    test('should throw ServerException on failed getAllProducts', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Error', 500);
      });

      remoteDataSource = ProductRemoteDataSourceImpl(mockClient);

      expect(() => remoteDataSource.getAllProducts(), throwsA(isA<ServerException>()));
    });
  });
}
