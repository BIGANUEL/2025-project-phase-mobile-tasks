import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:anuel/features/product/data/datasources/product_local_data_source_impl.dart';
import 'package:anuel/features/product/data/models/product_model.dart';

void main() {
  late SharedPreferences sharedPreferences;
  late ProductLocalDataSourceImpl localDataSource;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    localDataSource = ProductLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  });

  final productModel1 = ProductModel(id: 1, name: 'Phone', price: 100.0,description: 'phone',imageUrl: 'test');
  final productModel2 = ProductModel(id: 2, name: 'Laptop', price: 250.0,description: 'phone',imageUrl: 'test');
  final productList = [productModel1, productModel2];

  test('should cache a product list', () async {
    await localDataSource.cacheProductList(productList);

    final result = sharedPreferences.getString('CACHED_PRODUCT_LIST');
    expect(result, isNotNull);
  });

  test('should return the cached product list', () async {
    await sharedPreferences.setString(
      'CACHED_PRODUCT_LIST',
      json.encode(productList.map((e) => e.toJson()).toList()),
    );

    final result = await localDataSource.getLastProductList();
    expect(result.length, productList.length);
    expect(result.first.name, productModel1.name);
  });

  test('should return specific product by id', () async {
    await localDataSource.cacheProductList(productList);

    final result = await localDataSource.getLastProductById(2);
    expect(result.name, 'Laptop');
  });

  test('should cache single product and overwrite if exists', () async {
    final updatedProduct = ProductModel(id: 1, name: 'Updated Phone', price: 120.0,imageUrl: 'test',description: 'phone');

    await localDataSource.cacheProductList(productList);
    await localDataSource.cacheProduct(updatedProduct);

    final result = await localDataSource.getLastProductById(1);
    expect(result.name, 'Updated Phone');
  });

  test('should throw CacheException when getting non-existing id', () async {
    await localDataSource.cacheProductList(productList);

    expect(() => localDataSource.getLastProductById(99),
        throwsA(isA<CacheException>()));
  });

  test('should throw CacheException when no product list is cached', () async {
    sharedPreferences.remove('CACHED_PRODUCT_LIST');

    expect(() => localDataSource.getLastProductList(),
        throwsA(isA<CacheException>()));
  });
}
