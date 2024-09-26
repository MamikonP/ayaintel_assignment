import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRespositoryImp implements AuthRepository {
  AuthRespositoryImp();

  @override
  Future<UserEntity> signInWithEmailPassword(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> signUpWithEmailPassword(String email, String password) {
    throw UnimplementedError();
  }
}
