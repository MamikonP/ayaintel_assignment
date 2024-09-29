import '../entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<String> signInWithEmailPassword(String email, String password);
  Future<String> signUpWithEmailPassword(String email, String password);
  Future<void> resetPassword(String email);
  Future<void> logout();
  Future<UserEntity?> getLoggedInUser();
}
