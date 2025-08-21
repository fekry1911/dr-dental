import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_dental/core/app_export.dart';
import 'package:dr_dental/data/models/patient_model.dart';
import 'package:dr_dental/featuers/home/screens/patients/logic/add_patient_cubit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../logic/patient_data_cubit.dart';

Future<void> showStyledDatePickerDialogData(
  BuildContext context,
  PatientModel patientodel,
) async {
  DateTime? selectedDay;
  String? selectedTime;
  final cubit = context.read<PatientDataCubit>();

  List<String> generateTimeSlots() {
    List<String> slots = [];
    for (int hour = 10; hour <= 23; hour++) {
      final period = hour < 12 ? "AM" : "PM";
      final displayHour = hour > 12 ? hour - 12 : hour;
      slots.add("$displayHour:00 $period");
    }
    return slots;
  }

  showDialog(
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: cubit,
        child: Dialog(
          backgroundColor: Colors.white.withOpacity(0.95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StatefulBuilder(
              builder: (context, setState) {
                final slots = generateTimeSlots();

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Choose Date",
                      style: TextStyle(
                        fontSize: 18.fSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // --- Calendar ---
                    TableCalendar(
                      locale: "en_EN",
                      firstDay: DateTime.now(),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: selectedDay ?? DateTime.now(),
                      selectedDayPredicate: (day) {
                        return isSameDay(selectedDay, day);
                      },
                      onDaySelected: (selected, focused) {
                        setState(() {
                          selectedDay = selected;
                        });
                      },
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        outsideDaysVisible: false,
                      ),
                    ),
                    SizedBox(height: 16),

                    Text(
                      "Choose Time",
                      style: TextStyle(
                        fontSize: 18.fSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 200,
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: slots.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2.5,
                        ),
                        itemBuilder: (context, index) {
                          final time = slots[index];
                          final isSelected = time == selectedTime;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTime = time;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color:
                                    isSelected ? Colors.blue : Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? Colors.blueAccent
                                          : Colors.grey,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                time,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (selectedDay != null && selectedTime != null) {
                              String formattedDate =
                                  "${selectedDay!.year}-${selectedDay!.month.toString().padLeft(2, '0')}-${selectedDay!.day.toString().padLeft(2, '0')}";
                              print("📅 اليوم: $formattedDate");
                              print("🕒 الساعة: $selectedTime");
                              DateFormat format = DateFormat("hh:mm a");
                              DateTime time = format.parse(selectedTime!);

                              DateTime now = DateTime.now();
                              DateTime finalDateTime = DateTime(
                                now.year,
                                now.month,
                                now.day,
                                time.hour,
                                time.minute,
                              );

                              // تحويل لـ Timestamp
                              Timestamp timeStamp = Timestamp.fromDate(
                                finalDateTime,
                              );

                              // هنا بقى تعمل save في Firestore
                              cubit.addBookingToPatient(
                                formattedDate,
                                selectedTime!,
                                timeStamp,
                                patientodel,
                              );

                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            "Done",
                            style: TextStyle(
                              fontSize: 16.fSize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
