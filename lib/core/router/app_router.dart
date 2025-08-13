

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../featuers/home/presentation/demo.dart';
import '../../featuers/login_screen/logic/login_cubit.dart';
import '../../featuers/login_screen/presentation/login_screen.dart';
import '../../featuers/splash_screen/splash_screen.dart';
import '../app_export.dart';
import '../const/const.dart';
import '../di/di.dart';


class AppRouter {

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
            create: (context) => sl<LoginCubit>(),
            child: LoginScreen(),
          ),
        );
      case splashScreen:
        return MaterialPageRoute(
          builder:
              (_) => SplashScreen(),
        );
        case homeScreen:
          return MaterialPageRoute(builder: (_) {
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => sl<LoginCubit>()),
              ],
              child: HomeScreen());
          });



      default:
    }
    return null;
  }
}
