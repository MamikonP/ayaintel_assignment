import 'package:flutter/material.dart';

import 'core/main_repository_provider.dart';
import 'core/router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MainRepositoryProvider(
      builder: (context) => MaterialApp(
        title: 'Next Generation',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        theme: ThemeData(useMaterial3: true),
      ),
    );
  }
}
