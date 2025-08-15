import 'package:dr_dental/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ErrorShared extends StatelessWidget {
  const ErrorShared({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset(
          "assets/loading/Failed Status.json",
          width: 250.h,
          height: 250.h,
        )
    );
  }
}
