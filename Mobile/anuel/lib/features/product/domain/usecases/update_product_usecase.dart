import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import 'package:anuel/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class UpdateProductUsecase extends Usecase<Unit, Params> {
  final ProductRepository repository;

  UpdateProductUsecase(this.repository);

  @override
  Future<Either<Failure,Unit>> call(Params params)async {
    return await repository.updateProduct(params.product);
  }
}

class Params {
  final Product product;
  Params(this.product);
}
