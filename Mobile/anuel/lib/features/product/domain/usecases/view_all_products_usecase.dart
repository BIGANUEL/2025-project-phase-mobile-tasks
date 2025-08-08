import '../entities/product.dart';
import '../repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:anuel/core/usecases/usecase.dart';
import 'package:anuel/core/error/failure.dart';

class ViewAllProductsUsecase extends Usecase<List<Product>, NoParams> {
  final ProductRepository repository;

  ViewAllProductsUsecase(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await repository.getAllProducts();
  }
}
class NoParams {
  const NoParams();
}
