import 'package:dr_dental/featuers/home/screens/patients/data/model/booking_model.dart';
import 'package:dr_dental/featuers/user/logic/patient_data_cubit.dart';
import 'package:dr_dental/featuers/user/presentation/widgets/bottom_sheet.dart';
import 'package:dr_dental/featuers/user/presentation/widgets/calender.dart';
import 'package:dr_dental/featuers/user/presentation/widgets/last_session.dart';
import 'package:dr_dental/widgets/loading_widget.dart';
import 'package:dr_dental/widgets/share_error_animation.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../core/app_export.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Patient Details")),
      body: BlocConsumer<PatientDataCubit, PatientDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = context.read<PatientDataCubit>();
          if (state is PatientDataLoading) {
            return const Center(child: LoadingShared());
          }
          if (state is PatientDataFAil) {
            return Center(child: ErrorShared());
          }
          BookingModel? lastSession;
          if (cubit.bookings.isNotEmpty) {
            if (cubit.bookings.length > 1 &&
                cubit.bookings.first.reason == "reason") {
              lastSession = cubit.bookings[1];
            } else {
              lastSession = cubit.bookings.first;
            }
          }
          return  Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("name : ${cubit.patientModel!.name}",style: TextStyle(fontSize: 20.fSize, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10.h),
                    Text("Phone : ${cubit.patientModel!.phone}",style: TextStyle(fontSize: 20.fSize, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20.h),

                     Text(
                      " session",
                      style: TextStyle(fontSize: 20.fSize, fontWeight: FontWeight.bold),
                    ),
                     SizedBox(height: 12.h),

                    lastSession == null || lastSession.reason == "reason"
                        ? Center(child: const Text("No last session available"))
                        : LastSession(booking: lastSession),

                    SizedBox(height: 10.h),
                    const Text(
                      "Appointments",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12), // ...

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

                        return TimelineTile(
                          alignment: TimelineAlign.start,
                          isFirst: index == 0,
                          isLast: index == cubit.bookings.length - 1,
                          indicatorStyle: IndicatorStyle(
                            width: 20,
                            color: index == 0 ? Colors.blue : Colors.grey,
                            padding: const EdgeInsets.all(6),
                          ),
                          beforeLineStyle: const LineStyle(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                          afterLineStyle: const LineStyle(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                          endChild: Card(
                            color: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
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
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        width: 150,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "📌  ${item.reason ?? ""}",
                                              style: const TextStyle(
                                                color: Colors.black54,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              "📌  ${item.reason ?? ""}",
                                              style: const TextStyle(
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      cubit.deletePatientAppointments(
                                        cubit.patientModel!.id!,
                                        cubit.bookings[index].id!,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed:
                                    index == 0
                                        ? () {
                                      showEditProfileBottomSheet(
                                        context,
                                      );
                                    }
                                        : null,
                                    icon: Icon(
                                      index == 0 ? Icons.edit : Icons.check,
                                      color:
                                      index != cubit.bookings.length - 1
                                          ? Colors.blue
                                          : Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 20.h),

                    // Add booking button inside the same screen
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: Size(150.h, 50.h),
                              padding: EdgeInsets.symmetric(horizontal: 16.h),
                            ),
                            onPressed: () {
                              showStyledDatePickerDialogData(
                                context,
                                cubit.patientModel!,
                              );
                            },
                            icon: const Icon(Icons.add, color: Colors.white),
                            label: const Text(
                              "Add Appointment",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          );
        },
      ),
    );
  }
}
