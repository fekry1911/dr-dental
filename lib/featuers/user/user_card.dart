import 'package:dr_dental/core/app_export.dart';
import 'package:flutter/material.dart';

class PatientCard extends StatelessWidget {
  final String name;
  final String age;
  final bool showCheckbox;
  final bool isChecked;
  final ValueChanged<bool?>? onChanged;

  const PatientCard({
    super.key,
    required this.name,
    required this.age,
    this.showCheckbox = false,
    this.isChecked = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: EdgeInsets.all(10.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.h,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white),
            ),
            SizedBox(width: 18.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.h),
                Text(age, style: TextStyle(fontSize: 14.h, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
