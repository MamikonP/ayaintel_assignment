import 'package:flutter/material.dart';

import 'app.dart';
import 'core/util/firebase_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseUtil.of().initFirebase();
  runApp(const App());
}
