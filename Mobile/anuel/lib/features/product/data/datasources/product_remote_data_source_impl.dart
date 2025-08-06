import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';
import '../models/product_model.dart';
import 'product_remote_data_source.dart';
import 'package:anuel/core/error/failure.dart';

const String baseUrl = 'https://your-api-url.com/products';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl(this.client);

  @override
  Future<void> createProduct(ProductModel product) async {
    final response = await client.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
      );
    if (response.statusCode != 201) {
      throw ServerException('Failed to create product');
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await client.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw ServerException('Failed to fetch products');
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    final response = await client.put(
      Uri.parse('$baseUrl/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );

    if (response.statusCode != 200) {
      throw ServerException('Failed to update product');
    }
  }
  @override
  Future<ProductModel> getProductById(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException('Failed to fetch product with id $id');
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    final response = await client.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw ServerException('Failed to delete product');
    }
  }
}
