import '../entities/product.dart';
import '../repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:anuel/core/usecases/usecase.dart';
import 'package:anuel/core/error/failure.dart';

class CreateProductUsecase extends Usecase<Unit,  CreateProductParams> {
  final ProductRepository repository;

  CreateProductUsecase(this.repository);

  @override
  Future<Either<Failure,Unit>> call( CreateProductParams params) async{
    return await repository.createProduct(params.product);
  }
}

class CreateProductParams {
  final Product product;
  CreateProductParams({required this.product});
}
