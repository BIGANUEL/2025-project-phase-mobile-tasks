import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import 'package:anuel/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class ViewProductUsecase extends Usecase<Product, Params> {
  final ProductRepository repository;

  ViewProductUsecase(this.repository);

  @override
  Future<Either<Failure,Product>> call(Params params) async {
    return await repository.getProductById(params.id);
  }
}

class Params {
  final int id;

  Params(this.id);
}
