import 'package:flutter/material.dart';

import 'core/di/di.dart';
import 'core/helpers/cache_helper.dart';
import 'core/router/app_router.dart';
import 'featuers/splash_screen/splash_screen.dart';
import 'my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  setupServiceLocator();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp(appRouter: AppRouter(),));
}


