import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import 'package:anuel/features/product/domain/entities/product.dart';
import 'package:anuel/core/error/failure.dart';

import 'package:anuel/features/product/domain/usecases/create_product_usecase.dart';
import 'package:anuel/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:anuel/features/product/domain/usecases/update_product_usecase.dart';
import 'package:anuel/features/product/domain/usecases/view_product_usecase.dart';
import 'package:anuel/features/product/domain/usecases/view_all_products_usecase.dart';

import 'package:anuel/features/product/presentation/bloc/product_bloc.dart';
import 'package:anuel/features/product/presentation/bloc/product_event.dart';
import 'package:anuel/features/product/presentation/bloc/product_state.dart';

@GenerateMocks([
  ViewAllProductsUsecase,
  ViewProductUsecase,
  CreateProductUsecase,
  UpdateProductUsecase,
  DeleteProductUsecase,
])
import 'product_bloc_test.mocks.dart';

void main() {
  late MockViewAllProductsUsecase mockViewAllProductsUsecase;
  late MockViewProductUsecase mockViewProductUsecase;
  late MockCreateProductUsecase mockCreateProductUsecase;
  late MockUpdateProductUsecase mockUpdateProductUsecase;
  late MockDeleteProductUsecase mockDeleteProductUsecase;
  late ProductBloc productBloc;

  final tProduct = Product(
    id: 1,
    name: 'Test Product',
    description: 'Description',
    price: 10.0,
    imageUrl: 'http://example.com/image.png',
  );

  final tProductList = [tProduct];

  setUp(() {
    mockViewAllProductsUsecase = MockViewAllProductsUsecase();
    mockViewProductUsecase = MockViewProductUsecase();
    mockCreateProductUsecase = MockCreateProductUsecase();
    mockUpdateProductUsecase = MockUpdateProductUsecase();
    mockDeleteProductUsecase = MockDeleteProductUsecase();

    productBloc = ProductBloc(
      viewAllProductsUsecase: mockViewAllProductsUsecase,
      viewProductUsecase: mockViewProductUsecase,
      createProductUsecase: mockCreateProductUsecase,
      updateProductUsecase: mockUpdateProductUsecase,
      deleteProductUsecase: mockDeleteProductUsecase,
    );
  });

  test('initial state should be InitialState', () {
    expect(productBloc.state, InitialState());
  });

  group('LoadAllProductsEvent', () {
    test('emits [LoadingState, LoadedAllProductsState] when data is gotten successfully', () async {
      when(mockViewAllProductsUsecase.call(any))
          .thenAnswer((_) async => Right(tProductList));

      final expectedStates = [
        LoadingState(),
        LoadedAllProductsState(tProductList),
      ];

      expectLater(productBloc.stream, emitsInOrder(expectedStates));

      productBloc.add(const LoadAllProductsEvent());
    });

    test('emits [LoadingState, ErrorState] when getting data fails', () async {
      when(mockViewAllProductsUsecase.call(any))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      final expectedStates = [
        LoadingState(),
        ErrorState('Server Failure'),
      ];

      expectLater(productBloc.stream, emitsInOrder(expectedStates));

      productBloc.add(const LoadAllProductsEvent());
    });
  });

  group('GetSingleProductEvent', () {
    test('emits [LoadingState, LoadedSingleProductState] when product is gotten successfully', () async {
      when(mockViewProductUsecase.call(any))
          .thenAnswer((_) async => Right(tProduct));

      final expectedStates = [
        LoadingState(),
        LoadedSingleProductState(tProduct),
      ];

      expectLater(productBloc.stream, emitsInOrder(expectedStates));

      productBloc.add(GetSingleProductEvent(tProduct.id));
    });

    test('emits [LoadingState, ErrorState] when getting product fails', () async {
      when(mockViewProductUsecase.call(any))
          .thenAnswer((_) async => Left(CacheFailure('Cache Failure')));

      final expectedStates = [
        LoadingState(),
        ErrorState('Cache Failure'),
      ];

      expectLater(productBloc.stream, emitsInOrder(expectedStates));

      productBloc.add(GetSingleProductEvent(tProduct.id));
    });
  });

  group('CreateProductEvent', () {
    test('emits [LoadingState, LoadedAllProductsState] when creation is successful', () async {
      when(mockCreateProductUsecase.call(any))
          .thenAnswer((_) async => const Right(unit));
      when(mockViewAllProductsUsecase.call(any))
          .thenAnswer((_) async => Right(tProductList));

      final expectedStates = [
        LoadingState(),
        LoadedAllProductsState(tProductList), // Changed: only one LoadingState expected here
      ];

      expectLater(productBloc.stream, emitsInOrder(expectedStates));

      productBloc.add(CreateProductEvent(tProduct));
    });

    test('emits [LoadingState, ErrorState] when creation fails', () async {
      when(mockCreateProductUsecase.call(any))
          .thenAnswer((_) async => Left(ServerFailure('Creation Failed')));

      final expectedStates = [
        LoadingState(),
        ErrorState('Creation Failed'),
      ];

      expectLater(productBloc.stream, emitsInOrder(expectedStates));

      productBloc.add(CreateProductEvent(tProduct));
    });
  });

  group('UpdateProductEvent', () {
    test('emits [LoadingState, LoadedAllProductsState] when update is successful', () async {
      when(mockUpdateProductUsecase.call(any))
          .thenAnswer((_) async => const Right(unit));
      when(mockViewAllProductsUsecase.call(any))
          .thenAnswer((_) async => Right(tProductList));

      final expectedStates = [
        LoadingState(),
        LoadedAllProductsState(tProductList),  // Changed here as well
      ];

      expectLater(productBloc.stream, emitsInOrder(expectedStates));

      productBloc.add(UpdateProductEvent(tProduct));
    });

    test('emits [LoadingState, ErrorState] when update fails', () async {
      when(mockUpdateProductUsecase.call(any))
          .thenAnswer((_) async => Left(ServerFailure('Update Failed')));

      final expectedStates = [
        LoadingState(),
        ErrorState('Update Failed'),
      ];

      expectLater(productBloc.stream, emitsInOrder(expectedStates));

      productBloc.add(UpdateProductEvent(tProduct));
    });
  });

  group('DeleteProductEvent', () {
    test('emits [LoadingState, LoadedAllProductsState] when delete is successful', () async {
      when(mockDeleteProductUsecase.call(any))
          .thenAnswer((_) async => const Right(unit));
      when(mockViewAllProductsUsecase.call(any))
          .thenAnswer((_) async => Right(tProductList));

      final expectedStates = [
        LoadingState(),
        LoadedAllProductsState(tProductList),  // Changed here too
      ];

      expectLater(productBloc.stream, emitsInOrder(expectedStates));

      productBloc.add(DeleteProductEvent(tProduct.id));
    });

    test('emits [LoadingState, ErrorState] when delete fails', () async {
      when(mockDeleteProductUsecase.call(any))
          .thenAnswer((_) async => Left(ServerFailure('Delete Failed')));

      final expectedStates = [
        LoadingState(),
        ErrorState('Delete Failed'),
      ];

      expectLater(productBloc.stream, emitsInOrder(expectedStates));

      productBloc.add(DeleteProductEvent(tProduct.id));
    });
  });
}
