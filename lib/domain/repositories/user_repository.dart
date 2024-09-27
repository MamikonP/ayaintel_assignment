import '../entities/user_entity.dart';

abstract interface class UserRepository {
  Future<void> saveUser(UserEntity userEntity);
  Future<UserEntity?> getUser(String userId);
}
