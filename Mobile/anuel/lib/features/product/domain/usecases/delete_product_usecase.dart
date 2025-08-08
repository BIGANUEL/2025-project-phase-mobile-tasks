import '../repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:anuel/core/usecases/usecase.dart';
import 'package:anuel/core/error/failure.dart';

class DeleteProductUsecase extends Usecase<Unit, DeleteProductParams> {
  final ProductRepository repository;

  DeleteProductUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteProductParams params) async {
    return await repository.deleteProduct(params.id);
  }
}

class DeleteProductParams {
  final int id;

  DeleteProductParams(this.id);
}
