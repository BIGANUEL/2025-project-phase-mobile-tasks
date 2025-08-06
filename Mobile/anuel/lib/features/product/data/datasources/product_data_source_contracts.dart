import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<void> createProduct(ProductModel product);
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(int id);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(int id);
}

abstract class ProductLocalDataSource {
  Future<void> cacheProduct(ProductModel product);
  Future<void> cacheProductList(List<ProductModel> products);
  Future<List<ProductModel>> getLastProductList();
  Future<ProductModel> getLastProductById(int id);
}
