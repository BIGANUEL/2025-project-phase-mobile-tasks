import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'features/product/data/datasources/product_data_source_contracts.dart';
import 'features/product/data/datasources/product_remote_data_source_impl.dart';
import 'features/product/data/datasources/product_local_data_source_impl.dart';
import 'features/product/data/repositories/product_repository_impl.dart';

// Domain layer
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/view_all_products_usecase.dart';
import 'features/product/domain/usecases/view_product_usecase.dart';
import 'features/product/domain/usecases/create_product_usecase.dart';
import 'features/product/domain/usecases/update_product_usecase.dart';
import 'features/product/domain/usecases/delete_product_usecase.dart';

import 'features/product/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //!core
  sl.registerLazySingleton<http.Client>(() => http.Client());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //!bloc
  sl.registerFactory(
    () => ProductBloc(
      viewAllProductsUsecase: sl(),
      viewProductUsecase: sl(),
      createProductUsecase: sl(),
      updateProductUsecase: sl(),
      deleteProductUsecase: sl(),
    ),
  );

  //!Use cases
  sl.registerLazySingleton(() => ViewAllProductsUsecase(sl()));
  sl.registerLazySingleton(() => ViewProductUsecase(sl()));
  sl.registerLazySingleton(() => CreateProductUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase(sl()));

  //! Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //!Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()),
  );

  //! Local data source
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );
}
