import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/data_sources/auth_data_source.dart';
import '../data/data_sources/remote/firebase/firebase_data_source.dart';
import '../data/data_sources/user_data_source.dart';
import '../data/repositories/auth_respository_imp.dart';
import '../data/repositories/user_respository_imp.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/user_repository.dart';
import 'constants.dart';

class MainRepositoryProvider extends StatelessWidget {
  const MainRepositoryProvider({super.key, required this.builder});

  final MainRepositoryBuilderCallback builder;

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: <RepositoryProvider<dynamic>>[
          RepositoryProvider<FirebaseDataSource>(
            create: (context) => FirebaseDataSourceImp(
              auth: FirebaseAuth.instance,
              firestore: FirebaseFirestore.instance,
            ),
          ),
          RepositoryProvider<AuthDataSource>(
            create: (context) => AuthDataSourceImp(
              firebaseDataSource: RepositoryProvider.of(context),
            ),
          ),
          RepositoryProvider<UserDataSource>(
            create: (context) => UserDataSourceImp(
              firebaseDataSource: RepositoryProvider.of(context),
            ),
          ),
          RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepositoryImp(
              authDataSource: RepositoryProvider.of(context),
            ),
          ),
          RepositoryProvider<UserRepository>(
            create: (context) => UserRepositoryImp(
              userDataSource: RepositoryProvider.of(context),
            ),
          ),
        ],
        child: builder(context),
      );
}
