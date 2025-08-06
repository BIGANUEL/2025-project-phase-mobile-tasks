import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';
import 'product_local_data_source.dart';
import 'package:anuel/core/error/exception.dart';
const String cachedProductListKey = 'CACHED_PRODUCT_LIST';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheProduct(ProductModel product) async {
    final currentList = await getLastProductList();
    final updatedList = [...currentList.where((p) => p.id != product.id), product];
    await cacheProductList(updatedList);
  }

  @override
  Future<void> cacheProductList(List<ProductModel> products) async {
    final jsonList = products.map((e) => e.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await sharedPreferences.setString(cachedProductListKey, jsonString);
  }

  @override
  Future<List<ProductModel>> getLastProductList() async {
    final jsonString = sharedPreferences.getString(cachedProductListKey);
    if (jsonString != null) {
      final List<dynamic> decoded = json.decode(jsonString);
      return decoded.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw CacheException('No cached product list found');
    }
  }

  @override
  Future<ProductModel> getLastProductById(int id) async {
    final productList = await getLastProductList();
    try {
      return productList.firstWhere((p) => p.id == id);
    } catch (_) {
      throw CacheException('Product with id $id not found');
    }
  }
}


