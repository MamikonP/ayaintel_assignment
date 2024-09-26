import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';

class FirebaseUtil {
  FirebaseUtil._();

  factory FirebaseUtil.of() => _instance;

  static FirebaseUtil get _instance => FirebaseUtil._();

  Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    handleErrors();
  }

  void handleErrors() {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError =
        (Object exception, StackTrace stackTrace) {
      FirebaseCrashlytics.instance
          .recordError(exception, stackTrace, fatal: true);
      return true;
    };
  }
}
