import 'package:dr_dental/core/app_export.dart';
import 'package:dr_dental/featuers/home/screens/patients/logic/add_patient_cubit.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

Future<void> showStyledDatePickerDialog(BuildContext context) async {
  DateTime? selectedDay;
  final cubit = context.read<BookPatientCubit>();

  showDialog(
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: cubit,
        child: BlocListener<BookPatientCubit, BookPatientState>(
          listener: (context, state) {
            if (state is GetAllPatientsSucc) {
              Navigator.pop(context); // يقفل الديالوج
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("✅ تم الحجز بنجاح")),
              );
            } else if (state is GetAllPatientsFAil) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("❌ حصل خطأ: ${state.error}")),
              );
            }
          },
          child: Dialog(
            backgroundColor: Colors.white.withOpacity(0.95),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: StatefulBuilder(
                builder: (context, setState) {
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "cancel",
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
                              if (selectedDay != null) {
                                String formatted =
                                    "${selectedDay!.year}-${selectedDay!.month.toString().padLeft(2, '0')}-${selectedDay!.day.toString().padLeft(2, '0')}";
                                print(formatted);

                                cubit.bookPatient(formatted);

                                // ✅ قفل الديالوج بعد النجاح
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
        ),
      );
    },
  );
}
