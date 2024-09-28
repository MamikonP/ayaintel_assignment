import '../../core/constants.dart';
import '../../core/exceptions/api_exception.dart';
import '../models/user_model.dart';
import 'remote/firebase/firebase_data_source.dart';
import 'remote/firebase/firebase_mixin.dart';

abstract interface class UserDataSource {
  Future<void> saveUser(UserModel userModel);
  Future<UserModel?> getUserById(String id);
}

class UserDataSourceImp with FirebaseMixin implements UserDataSource {
  UserDataSourceImp({required this.firebaseDataSource});

  @override
  final FirebaseDataSource firebaseDataSource;

  @override
  Future<void> saveUser(UserModel userModel) async {
    if (userModel.id == null) {
      throw NotFoundException();
    }
    final FDocumentReference documentReference = firebaseDataSource.getDocument(
        await userCollectionReference, userModel.id!);
    if (!(await documentReference.get()).exists) {
      await documentReference.set(userModel.toJson());
    } else {
      await documentReference.update(userModel.toJson());
    }
  }

  @override
  Future<UserModel?> getUserById(String id) async {
    final documentReference =
        firebaseDataSource.getDocument(await userCollectionReference, id);
    final snapshot = await documentReference.get();
    return snapshot.data() == null
        ? null
        : UserModel.fromJson(snapshot.data()!);
  }
}
