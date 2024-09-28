import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constants.dart';


abstract interface class FirebaseDataSource {
  Future<UserCredential> signInWithEmailPassword(String email, String password);
  Future<UserCredential> signUpWithEmailPassword(String email, String password);
  FCollectionReference getCollection(String path);
  FDocumentReference getDocument(FCollectionReference reference, String docId);
}

class FirebaseDataSourceImp implements FirebaseDataSource {
  FirebaseDataSourceImp({required this.auth, required this.firestore});

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  @override
  Future<UserCredential> signInWithEmailPassword(
          String email, String password) async =>
      auth.signInWithEmailAndPassword(email: email, password: password);

  @override
  Future<UserCredential> signUpWithEmailPassword(
          String email, String password) async =>
      auth.createUserWithEmailAndPassword(email: email, password: password);

  @override
  FCollectionReference getCollection(String path) => firestore.collection(path);

  @override
  FDocumentReference getDocument(
          FCollectionReference reference, String docId) =>
      reference.doc(docId);
}
