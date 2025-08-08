import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import 'product_event.dart';
import 'product_state.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/create_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../../domain/usecases/update_product_usecase.dart';
import '../../domain/usecases/view_product_usecase.dart';
import '../../domain/usecases/view_all_products_usecase.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ViewAllProductsUsecase viewAllProductsUsecase;
  final ViewProductUsecase viewProductUsecase;
  final CreateProductUsecase createProductUsecase;
  final UpdateProductUsecase updateProductUsecase;
  final DeleteProductUsecase deleteProductUsecase;

  ProductBloc({
    required this.viewAllProductsUsecase,
    required this.viewProductUsecase,
    required this.createProductUsecase,
    required this.updateProductUsecase,
    required this.deleteProductUsecase,
  }) : super(InitialState()) {
    on<LoadAllProductsEvent>(_onLoadAllProducts);
    on<GetSingleProductEvent>(_onGetSingleProduct);
    on<CreateProductEvent>(_onCreateProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  Future<void> _onLoadAllProducts(
    LoadAllProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    final Either<Failure, List<Product>> result =
        await viewAllProductsUsecase(NoParams());
    result.fold(
      (failure) => emit(ErrorState(_mapFailureToMessage(failure))),
      (products) => emit(LoadedAllProductsState(products)),
    );
  }

  Future<void> _onGetSingleProduct(
    GetSingleProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    final Either<Failure, Product> result =
        await viewProductUsecase(ViewProductParams(event.id));
    result.fold(
      (failure) => emit(ErrorState(_mapFailureToMessage(failure))),
      (product) => emit(LoadedSingleProductState(product)),
    );
  }

  Future<void> _onCreateProduct(
    CreateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    final Either<Failure, Unit> result =
        await createProductUsecase(CreateProductParams(product: event.product));
    result.fold(
      (failure) => emit(ErrorState(_mapFailureToMessage(failure))),
      (_) => add(const LoadAllProductsEvent()),
    );
  }

  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    final Either<Failure, Unit> result =
        await updateProductUsecase(UpdateProductParams(product: event.product));
    result.fold(
      (failure) => emit(ErrorState(_mapFailureToMessage(failure))),
      (_) => add(const LoadAllProductsEvent()),
    );
  }

  Future<void> _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    final Either<Failure, Unit> result =
        await deleteProductUsecase(DeleteProductParams(event.id));
    result.fold(
      (failure) => emit(ErrorState(_mapFailureToMessage(failure))),
      (_) => add(const LoadAllProductsEvent()),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is CacheFailure) {
      return failure.message;
    } else {
      return 'Unexpected error';
    }
  }
}
