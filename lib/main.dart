import 'package:flutter/material.dart';

import 'app.dart';
import 'core/main_bloc_provider.dart';
import 'core/main_repository_provider.dart';
import 'core/util/firebase_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseUtil.of().initFirebase();
  runApp(
    MainRepositoryProvider(
      builder: (context) => const MainBlocProvider(child: App()),
    ),
  );
}
