import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> signIn(String email, String password) async {
    return await remoteDataSource.signIn(email, password);
  }

  @override
  Future<User> signUp(String name, String email, String password) async {
    return await remoteDataSource.signUp(name, email, password);
  }
}
