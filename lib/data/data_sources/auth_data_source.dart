import '../models/user_model.dart';
import 'remote/firebase/firebase_data_source.dart';
import 'remote/firebase/firebase_mixin.dart';
import 'user_data_source.dart';

abstract interface class AuthDataSource {
  Future<String> signUpWithEmailPassword(String email, String password);
  Future<String> signInWithEmailPassword(String email, String password);
  Future<void> resetPassword(String email);
  Future<void> logout();
  Future<UserModel?> getLoggedinUser();
}

class AuthDataSourceImp with FirebaseMixin implements AuthDataSource {
  AuthDataSourceImp({
    required this.firebaseDataSource,
    required this.userDataSource,
  });

  @override
  final FirebaseDataSource firebaseDataSource;
  final UserDataSource userDataSource;

  @override
  Future<String> signInWithEmailPassword(String email, String password) async {
    final credential =
        await firebaseDataSource.signInWithEmailPassword(email, password);
    return credential.user?.uid ?? '';
  }

  @override
  Future<String> signUpWithEmailPassword(String email, String password) async {
    final credential =
        await firebaseDataSource.signUpWithEmailPassword(email, password);
    return credential.user?.uid ?? '';
  }

  @override
  Future<void> resetPassword(String email) async =>
      firebaseDataSource.resetPassword(email);

  @override
  Future<void> logout() async => firebaseDataSource.logout();

  @override
  Future<UserModel?> getLoggedinUser() async {
    final user = await firebaseDataSource.getLoggedinUser();
    if (user == null) {
      return null;
    }
    return userDataSource.getUserById(user.uid);
  }
}
