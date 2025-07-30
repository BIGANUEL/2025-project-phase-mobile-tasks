import '../../../../core/usecases/usecase.dart';
import '../repositories/product_repository.dart';
import 'package:anuel/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class DeleteProductUsecase extends Usecase<Unit,Params>{
  final ProductRepository repository;

  DeleteProductUsecase(this.repository);

  @override
  Future<Either<Failure,Unit>>call(Params params) async{
    return await repository.deleteProduct(params.id);
  }
}

class Params {
  final int id;

  Params(this.id);
}