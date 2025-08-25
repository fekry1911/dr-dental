import 'package:dr_dental/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShared extends StatelessWidget {
  const LoadingShared({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(   // يدي حجم كامل للـ ListView
      child: Shimmer.fromColors(
        highlightColor: Colors.grey.shade300,
        baseColor: Colors.grey.shade100,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        color: Colors.black,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                      ),
                      Container(
                        height: 12,
                        width: 150,
                        color: Colors.black,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                      ),
                    ],
                  ),
                ),
              ],
            ).animate().slideY(
              duration: 500.ms,
              begin: 1.0,
              end: 0.0,
            ),
          ),
        ),
      ),
    );
  }
}
