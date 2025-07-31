import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:anuel/core/platform/network_info.dart';
import 'package:anuel/features/product/data/datasources/product_local_data_source.dart';
import 'package:anuel/features/product/data/datasources/product_remote_data_source.dart';
import 'package:anuel/features/product/data/repositories/product_repository_impl.dart';
import './product_repository_impl_test.mocks.dart';

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

  // Your tests here
}
