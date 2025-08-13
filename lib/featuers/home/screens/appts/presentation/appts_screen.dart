import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../../../../../core/app_export.dart';
import '../../../../login_screen/logic/login_cubit.dart';

class AppptsScreen extends StatefulWidget {
  const AppptsScreen({super.key});

  @override
  State<AppptsScreen> createState() => _AppptsScreenState();
}

class _AppptsScreenState extends State<AppptsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 13.0.h, right: 13.0.h),
        child: Column(
          children: [
            CalendarCarousel<Event>(
              onDayPressed: (DateTime date, List<Event> events) {
               
              },
              weekendTextStyle: TextStyle(color: Colors.red),
              thisMonthDayBorderColor: Colors.grey,
              selectedDateTime: _currentDate,
              markedDatesMap: _markedDateMap,
              height: 400.h,
              selectedDayButtonColor: Colors.blue,
              selectedDayBorderColor: Colors.blueAccent,
            ),
            SizedBox(height: 20.h),
            Divider(height: 4.h, thickness: 1),
            SizedBox(height: 20.h),

            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(bottom: 80.h),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 100.h,
                    child: PatientCard(
                      name: "abdo fekry",
                      age: "30",
                      diagnosis: "asdasdbkasdasdbadkhabdkhasbd",
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 5.h);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
