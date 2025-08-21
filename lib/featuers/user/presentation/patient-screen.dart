import 'package:dr_dental/featuers/user/logic/patient_data_cubit.dart';
import 'package:dr_dental/featuers/user/presentation/widgets/calender.dart';
import 'package:dr_dental/widgets/loading_widget.dart';
import 'package:dr_dental/widgets/share_error_animation.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/calender.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientDataCubit, PatientDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<PatientDataCubit>();
        if (state is PatientDataLoading) {
          return const Center(child: LoadingShared());
        }
        if (state is PatientDataFAil) {
          return Center(child: ErrorShared());
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(cubit.patientModel!.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  cubit.deletePatient(cubit.patientModel!.id!).then((value) {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "📞 Phone: ${cubit.patientModel!.phone}",
                    style: TextStyle(fontSize: 20.h),
                  ),
                  SizedBox(height: 13.h),
                  Text(
                    "🎂 Age: ${cubit.patientModel!.age}",
                    style: TextStyle(fontSize: 20.h),
                  ),
                  SizedBox(height: 13.h),
                  Text(
                    "🚻 Gender: ${cubit.patientModel!.gender}",
                    style: TextStyle(fontSize: 20.h),
                  ),
                  SizedBox(height: 20.h),

                  // --- Appointments Section ---
                  const Divider(thickness: 1),
                  const Text(
                    "Appointments",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  cubit.bookings.isEmpty
                      ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "No bookings found 🗓️",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      )
                      : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cubit.bookings.length,
                        itemBuilder: (context, index) {
                          final item = cubit.bookings[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Timeline Line + Dot
                              Column(
                                children: [
                                  Container(
                                    width: 2,
                                    height: 20,
                                    color:
                                        index == 0
                                            ? Colors.transparent
                                            : Colors.grey,
                                  ),
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color:
                                          index == 0
                                              ? Colors.blue
                                              : Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    width: 2,
                                    height: 60,
                                    color:
                                        index == cubit.bookings.length - 1
                                            ? Colors.transparent
                                            : Colors.grey,
                                  ),
                                ],
                              ),
                              SizedBox(width: 12),

                              /// Appointment Card
                              Expanded(
                                child: Card(
                                  color: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${item.day} | ${item.time}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              item.reason ?? "",
                                              style: TextStyle(
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        IconButton(onPressed: (){
                                          cubit.deletePatientAppointments(cubit.patientModel!.id!, cubit.bookings[index].id!);
                                        }, icon: Icon(Icons.delete,color: Colors.red,)),
                                        IconButton(onPressed: index == cubit.bookings.length - 1?null:(){
                                          print(cubit.bookings);
                                        }, icon: Icon(index != cubit.bookings.length - 1?Icons.edit:Icons.check,color: index != cubit.bookings.length - 1?Colors.blue:Colors.green,))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                   SizedBox(height: 20.h),

                  // Add booking button inside the same screen
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showStyledDatePickerDialogData(context,cubit.patientModel!);

                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Add Appointment"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
