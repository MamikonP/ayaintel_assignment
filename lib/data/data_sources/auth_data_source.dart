import '../models/user_model.dart';
import 'remote/firebase/firebase_data_source.dart';
import 'remote/firebase/firebase_mixin.dart';

abstract interface class AuthDataSource {
  Future<String> signUpWithEmailPassword(String email, String password);
  Future<String> signInWithEmailPassword(String email, String password);
  Future<UserModel?> getUserById(String id);
}

class AuthDataSourceImp with FirebaseMixin implements AuthDataSource {
  AuthDataSourceImp({required this.firebaseDataSource});

  @override
  final FirebaseDataSource firebaseDataSource;

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
  Future<UserModel?> getUserById(String id) async {
    final documentReference =
        firebaseDataSource.getDocument(await userCollectionReference, id);
    final snapshot = await documentReference.get();
    return snapshot.data() == null
        ? null
        : UserModel.fromJson(snapshot.data()!);
  }
}
