import '../entities/product.dart';
import '../repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:anuel/core/usecases/usecase.dart';
import 'package:anuel/core/error/failure.dart';

class ViewProductUsecase extends Usecase<Product, ViewProductParams> {
  final ProductRepository repository;

  ViewProductUsecase(this.repository);

  @override
  Future<Either<Failure, Product>> call(ViewProductParams params) async {
    return await repository.getProductById(params.id);
  }
}

class ViewProductParams {
  final int id;

  ViewProductParams(this.id);
}
