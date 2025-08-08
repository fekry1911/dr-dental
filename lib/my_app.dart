import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'core/const/const.dart';
import 'core/router/app_router.dart';
import 'core/utils/size_utils.dart';
import 'featuers/splash_screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return       MaterialApp(
          onGenerateRoute: appRouter.generateRoute,
          initialRoute: splashScreen,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
