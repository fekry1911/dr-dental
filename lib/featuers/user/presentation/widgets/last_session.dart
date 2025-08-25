import 'package:dr_dental/core/app_export.dart';
import 'package:flutter/material.dart';
import '../../../home/screens/patients/data/model/booking_model.dart';

class LastSessionAnimated extends StatelessWidget {
  final BookingModel booking;
  const LastSessionAnimated({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white, // خلفية هادية
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Time",
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.blueAccent)),
          SizedBox(height: 3.h),
          Text(
            "${booking.day} | ${booking.time}",
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16.h),
          ),
          SizedBox(height: 8.h),
          Divider(thickness: 1.5, color: Colors.grey.shade300),
          SizedBox(height: 8.h),
          Text("Status",
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.blueAccent)),
          SizedBox(height: 3.h),
          Text(
            "${booking.reason}",
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16.h),
          ),
          if (booking.note != null && booking.note!.isNotEmpty) ...[
            SizedBox(height: 5.h),
            Text(
              "📝 Note: ${booking.note}",
              style: TextStyle(
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                  fontSize: 14.h),
            ),
          ],
          SizedBox(height: 8.h),
          Divider(thickness: 1.5, color: Colors.grey.shade300),
          SizedBox(height: 8.h),
          Text("Cost",
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.blueAccent)),
          SizedBox(height: 3.h),
          Text(
            "${booking.cost} \$",
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16.h),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                "Paid: ${booking.paid} \$",
                style: const TextStyle(color: Colors.green),
              ),
              const Spacer(),
              Text(
                "Remaining: ${booking.cost - booking.paid} \$",
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
