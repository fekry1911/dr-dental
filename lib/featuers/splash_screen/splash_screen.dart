import 'package:dr_dental/core/const/const.dart';
import 'package:dr_dental/core/helpers/extentions/context_extention.dart';
import 'package:flutter/material.dart';

import '../../core/utils/size_utils.dart';
import '../../main.dart';
import '../login_screen/presentation/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      context.pushAndRemoveUntil(loginScreen);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Image.asset("assets/splash_screen/Frame.png", fit: BoxFit.cover),
    );
  }
}
