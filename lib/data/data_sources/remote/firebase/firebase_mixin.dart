import '../../../../core/constants.dart';
import 'firebase_data_source.dart';

mixin FirebaseMixin {
  FirebaseDataSource get firebaseDataSource;

  Future<FCollectionReference> get userCollectionReference async =>
      firebaseDataSource.getCollection(kUserCollection);
}
