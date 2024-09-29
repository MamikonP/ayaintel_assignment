import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_data_source.dart';

class AuthRepositoryImp implements AuthRepository {
  AuthRepositoryImp({required this.authDataSource});

  final AuthDataSource authDataSource;

  @override
  Future<String> signInWithEmailPassword(String email, String password) async =>
      authDataSource.signInWithEmailPassword(email, password);

  @override
  Future<String> signUpWithEmailPassword(String email, String password) async =>
      authDataSource.signUpWithEmailPassword(email, password);

  @override
  Future<void> resetPassword(String email) async =>
      authDataSource.resetPassword(email);

  @override
  Future<void> logout() async => authDataSource.logout();

  @override
  Future<UserEntity?> getLoggedInUser() async {
    final user = await authDataSource.getLoggedinUser();
    return user?.toEntity();
  }
}
