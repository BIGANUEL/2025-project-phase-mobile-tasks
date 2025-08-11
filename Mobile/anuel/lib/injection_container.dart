import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Auth feature imports
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/sign_in_usecase.dart'; // Add this import
import 'features/auth/domain/usecases/sign_up_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

// Product feature imports
import 'features/product/data/datasources/product_data_source_contracts.dart';
import 'features/product/data/datasources/product_remote_data_source_impl.dart';
import 'features/product/data/datasources/product_local_data_source_impl.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/view_all_products_usecase.dart';
import 'features/product/domain/usecases/view_product_usecase.dart';
import 'features/product/domain/usecases/create_product_usecase.dart';
import 'features/product/domain/usecases/update_product_usecase.dart';
import 'features/product/domain/usecases/delete_product_usecase.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  sl.registerLazySingleton<http.Client>(() => http.Client());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //! Product Bloc
  sl.registerFactory(
    () => ProductBloc(
      viewAllProductsUsecase: sl(),
      viewProductUsecase: sl(),
      createProductUsecase: sl(),
      updateProductUsecase: sl(),
      deleteProductUsecase: sl(),
    ),
  );

  //! Auth Bloc (for signup/login)
  sl.registerFactory(
    () => AuthBloc(
      signUp: sl(),
      signIn: sl(), // This requires SignInUsecase to be registered
    ),
  );

  //! Product Use Cases
  sl.registerLazySingleton(() => ViewAllProductsUsecase(sl()));
  sl.registerLazySingleton(() => ViewProductUsecase(sl()));
  sl.registerLazySingleton(() => CreateProductUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase(sl()));

  //! Auth Use Cases
  sl.registerLazySingleton(() => SignUpUsecase(sl()));
  sl.registerLazySingleton(() => SignInUsecase(sl())); // Add this line

  //! Product Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //! Auth Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  //! Product Data Sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()), // Changed to named parameter
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Auth Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );
}