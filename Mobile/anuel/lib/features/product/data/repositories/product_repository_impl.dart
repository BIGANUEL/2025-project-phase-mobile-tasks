import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getAllProducts();
        localDataSource.cacheProductList(products);
      } catch (e) {
        return const Left(
          ServerFailure('Failed to fetch products from server'),
        );
      }
    } else {
      try {
        final products = await localDataSource.getLastProductList();
        return Right(products);
      } catch (e) {
        return const Left(CacheFailure('No cached data avaliable'));
      }
    }
    return const Left(ServerFailure('Unexpected error'));
  }

  @override
  Future<Either<Failure, Product>> getProductById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await remoteDataSource.getProductById(id);
        localDataSource.cacheProduct(product);
      } catch (e) {
        return const Left(ServerFailure('Failed to fetch product from server'));
      }
    } else {
      try {
        final product = await localDataSource.getLastProductById(id);
        return Right(product);
      } catch (e) {
        return const Left(CacheFailure('No cached data avaliable'));
      }
    }
    return const Left(ServerFailure('Unexpected error'));
  }

  @override
  Future<Either<Failure, Unit>> createProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final model = ProductModel(
          id: product.id,
          name: product.name,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
        );
        await remoteDataSource.createProduct(model);
        return const Right(unit);
      } catch (e) {
        return const Left(ServerFailure('Failed to create product'));
      }
    } else {
      return const Left(ServerFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final model = ProductModel(
          id: product.id,
          name: product.name,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
        );
        await remoteDataSource.updateProduct(model);
        return const Right(unit);
      } catch (e) {
        return const Left(ServerFailure('Failed to update product'));
      }
    } else {
      return const Left(ServerFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProduct(id);
        return const Right(unit);
      } catch (e) {
        return const Left(ServerFailure('Failed to delete product'));
      }
    } else {
      return const Left(ServerFailure('No internet Connection'));
    }
  }
}
