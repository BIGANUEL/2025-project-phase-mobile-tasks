import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:anuel/features/product/domain/entities/product.dart';
import 'package:anuel/core/error/failure.dart';
import 'package:anuel/features/product/domain/usecases/create_product_usecase.dart';
import '../../../../mocks/mock_product_repository.mocks.dart';

void main() {
  late CreateProductUsecase usecase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = CreateProductUsecase(mockRepository);
  });

  const tProduct = Product(
    id: 1,
    name: 'Test Product',
    description: 'Testing',
    price: 99.99,
    imageUrl: 'https://example.com/image.png',
  );

  final params = Params(tProduct);

  test('should return Right(unit) when creation is successful', () async {
    // arrange
    when(mockRepository.createProduct(tProduct))
        .thenAnswer((_) async => const Right(unit));

    // act
    final result = await usecase(params);

    // assert
    expect(result, const Right(unit));
    verify(mockRepository.createProduct(tProduct)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Left(ServerFailure) when repository fails', () async {
    // arrange
    when(mockRepository.createProduct(tProduct))
        .thenAnswer((_) async => const Left(ServerFailure("Creation failed")));

    // act
    final result = await usecase(params);

    // assert
    expect(result, const Left(ServerFailure("Creation failed")));
    verify(mockRepository.createProduct(tProduct)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
