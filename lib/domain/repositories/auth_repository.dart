import '../entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<UserEntity> signInWithEmailPassword(String email, String password);
  Future<UserEntity> signUpWithEmailPassword(String email, String password);
}
