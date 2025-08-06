import 'package:anuel/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:anuel/features/product/domain/entities/product.dart';
import 'package:anuel/core/error/failure.dart';
import 'package:anuel/core/platform/network_info.dart';
import 'package:anuel/features/product/data/datasources/product_data_source_contracts.dart';
import 'package:anuel/features/product/data/repositories/product_repository_impl.dart';
import './product_repository_impl_test.mocks.dart';
import 'package:dartz/dartz.dart';

@GenerateMocks([
  ProductRemoteDataSource,
  ProductLocalDataSource,
  NetworkInfo,
])
void main() {
  late ProductRepositoryImpl repository;
  late MockProductRemoteDataSource mockRemoteDataSource;
  late MockProductLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockLocalDataSource = MockProductLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tProduct = ProductModel(
    id: 1,
    name: 'Test Product',
    description: 'Testing',
    price: 99.99,
    imageUrl: 'https://example.com/image.png',
  );

  group('createProduct', () {
    test('should call remote data source when connected', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.createProduct(tProduct)).thenAnswer((_) async => null);

      final result = await repository.createProduct(tProduct);

      expect(result, const Right(unit));
      verify(mockRemoteDataSource.createProduct(tProduct));
    });

    test('should return ServerFailure when remote throws exception', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.createProduct(tProduct)).thenThrow(Exception());

      final result = await repository.createProduct(tProduct);

      expect(result, isA<Left<Failure, Unit>>());
    });

    test('should return ServerFailure when not connected', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.createProduct(tProduct);

      expect(result, const Left(ServerFailure("No internet connection")));
    });
  });
}
