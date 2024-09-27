import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/user_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImp implements UserRepository {
  UserRepositoryImp({required this.userDataSource});

  final UserDataSource userDataSource;

  @override
  Future<UserEntity?> getUser(String userId) async {
    final model = await userDataSource.getUserById(userId);
    return model?.toEntity();
  }

  @override
  Future<void> saveUser(UserEntity userEntity) async {
    await userDataSource.saveUser(UserModel.fromEntity(userEntity));
  }
}
