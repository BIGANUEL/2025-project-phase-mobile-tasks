import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<void> createProduct(ProductModel product);
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(int id);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(int id);
}
