import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProduct(ProductModel product);
  Future<void> cacheProductList(List<ProductModel> products);
  Future<List<ProductModel>> getLastProductList();
  Future<ProductModel> getLastProductById(int id);
}
