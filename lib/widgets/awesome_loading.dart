import 'package:dr_dental/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset(
          "assets/loading/Loading animation blue.json",
          width: 250.h,
          height: 250.h,
        )
    );
  }
}
