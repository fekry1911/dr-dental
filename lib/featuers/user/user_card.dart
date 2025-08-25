import 'package:dr_dental/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PatientCard extends StatelessWidget {
  final String name;
  final String ageGender;
  final String phone;
  final String address;
  final String imageUrl;

  const PatientCard({
    super.key,
    required this.name,
    required this.ageGender,
    required this.phone,
    required this.address,
    this.imageUrl = "",
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.blue.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // خلفية هادية للكارت
          borderRadius: BorderRadius.circular(18.0),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(14.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 28.h,
                backgroundColor: Colors.blue.shade100,
                child: Icon(Icons.person, color: Colors.blue.shade700, size: 28.h),
              ),
              SizedBox(width: 16.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18.h,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      ageGender,
                      style: TextStyle(
                        fontSize: 14.h,
                        color: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 16.h, color: Colors.blueGrey),
                        SizedBox(width: 5.h),
                        Text(
                          phone,
                          style: TextStyle(fontSize: 14.h, color: Colors.blueGrey),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      address,
                      style: TextStyle(fontSize: 14.h, color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.blueGrey),
            ],
          ),
        ),
      ),
    )
    // Animation
        .animate()
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.2, end: 0, duration: 500.ms);
  }
}
