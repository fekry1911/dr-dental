import 'package:dr_dental/featuers/user/presentation/patient-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/patient_model.dart';
import '../../featuers/home/logic/home_cubit.dart';
import '../../featuers/home/presentation/demo.dart';
import '../../featuers/login_screen/logic/login_cubit.dart';
import '../../featuers/login_screen/presentation/login_screen.dart';
import '../../featuers/splash_screen/splash_screen.dart';
import '../../featuers/user/logic/patient_data_cubit.dart';
import '../const/const.dart';
import '../di/di.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (context) => sl<LoginCubit>(),
            child: LoginScreen(),
          ),
          transition: TransitionType.slideFromRight,
        );

      case splashScreen:
        return _buildPageRoute(
          settings,
          SplashScreen(),
          transition: TransitionType.fade,
        );

      case homeScreen:
        return _buildPageRoute(
          settings,
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<LoginCubit>()),
              BlocProvider(create: (context) => sl<HomeCubit>()),
            ],
            child: HomeScreen(),
          ),
          transition: TransitionType.scale,
        );

      case patientScreen:
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (context) => sl<PatientDataCubit>()
              ..getPatientDataFunc(settings.arguments as String),
            child: PatientScreen(),
          ),
          transition: TransitionType.slideFromBottom,
        );

      default:
        return null;
    }
  }

  /// Helper function to build custom transitions
  PageRouteBuilder _buildPageRoute(RouteSettings settings, Widget screen,
      {TransitionType transition = TransitionType.fade}) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transition) {
          case TransitionType.slideFromRight:
            return SlideTransition(
              position: animation.drive(
                Tween(begin: const Offset(1, 0), end: Offset.zero)
                    .chain(CurveTween(curve: Curves.easeInOut)),
              ),
              child: child,
            );
          case TransitionType.slideFromBottom:
            return SlideTransition(
              position: animation.drive(
                Tween(begin: const Offset(0, 1), end: Offset.zero)
                    .chain(CurveTween(curve: Curves.easeInOut)),
              ),
              child: child,
            );
          case TransitionType.scale:
            return ScaleTransition(
              scale: animation.drive(
                Tween(begin: 0.8, end: 1.0)
                    .chain(CurveTween(curve: Curves.easeInOut)),
              ),
              child: child,
            );
          case TransitionType.fade:
          default:
            return FadeTransition(
              opacity: animation,
              child: child,
            );
        }
      },
    );
  }
}

enum TransitionType {
  slideFromRight,
  slideFromBottom,
  fade,
  scale,
}
