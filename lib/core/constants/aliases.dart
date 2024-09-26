import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

typedef MapDynamic = Map<dynamic, dynamic>;

typedef MapStrDynamic = Map<String, dynamic>;

typedef MainRepositoryBuilderCallback = Widget Function(BuildContext context);

typedef FCollectionReference = CollectionReference<MapStrDynamic>;

typedef FQueryDocumentSnapshot = QueryDocumentSnapshot<MapStrDynamic>;

typedef FDocumentReference = DocumentReference<MapStrDynamic>;

typedef FDocumentSnapshot = DocumentSnapshot<MapStrDynamic>;

typedef FQuerySnapshot = QuerySnapshot<MapStrDynamic>;
