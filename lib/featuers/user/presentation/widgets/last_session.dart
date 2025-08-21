import 'package:dr_dental/core/app_export.dart';
import 'package:flutter/material.dart';

import '../../../home/screens/patients/data/model/booking_model.dart';

class LastSession extends StatelessWidget {
  LastSession({super.key, required this.booking});

  BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Time"),
              SizedBox(height: 3.h),
              Text(
                "${booking.day} | ${booking.time}",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.h,
                ),
              ),
              SizedBox(height: 8.h),
              Divider(thickness: 2),
              SizedBox(height: 8.h),
              Text("status"),
              SizedBox(height: 3.h),
              Text(
                "${booking.reason}",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.h,
                ),
              ),
              SizedBox(height: 8.h),
              Divider(thickness: 2),
              SizedBox(height: 8.h),
              Text("cost"),
              SizedBox(height: 3.h),
              Text(
                "${booking.cost} \$",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.h,
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "${booking.paid} \$",
                      style: TextStyle(color: Colors.green),
                    ),
                    Spacer(),
                    Text(
                      "${booking.cost-booking.paid} \$",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
