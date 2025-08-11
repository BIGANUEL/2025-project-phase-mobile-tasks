import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignUpUsecase {
  final AuthRepository repository;

  SignUpUsecase(this.repository);

  Future<User> call(String name, String email, String password) {
    return repository.signUp(name, email, password);
  }
}
