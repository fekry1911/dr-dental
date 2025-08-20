import 'package:dr_dental/featuers/user/logic/patient_data_cubit.dart';
import 'package:dr_dental/featuers/user/logic/patient_data_cubit.dart';
import 'package:dr_dental/widgets/loading_widget.dart';
import 'package:dr_dental/widgets/share_error_animation.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../data/models/patient_model.dart';
import '../../home/screens/patients/data/model/booking_model.dart';

class PatientScreen extends StatelessWidget {

  const PatientScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientDataCubit, PatientDataState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit=context.read<PatientDataCubit>();
        if(state is PatientDataLoading){
          return const Center(child: LoadingShared());
        }
        if(state is PatientDataFAil){
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
                icon: const Icon(Icons.delete,color: Colors.red,),
                onPressed: () {
                  cubit.deletePatient(cubit.patientModel!.id!).then((value){
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
                  Text("📞 Phone: ${cubit.patientModel!.phone}",style: TextStyle(fontSize: 20.h)),
                   SizedBox(height: 13.h),
                  Text("🎂 Age: ${cubit.patientModel!.age}",style: TextStyle(fontSize: 20.h)),
                   SizedBox(height: 13.h),
                  Text("🚻 Gender: ${cubit.patientModel!.gender}",style: TextStyle(fontSize: 20.h),),
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
                      : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cubit.bookings.length,
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      BookingModel booking = cubit.bookings[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: ListTile(
                          leading: const Icon(
                              Icons.calendar_today, color: Colors.blue),
                          title: Text("Date: ${booking.day}"),
                          subtitle: Text("Notes: ${booking.reason ?? "—"}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              cubit.deletePatientAppointments(cubit.patientModel!.id!,booking.id!);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Add booking button inside the same screen
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: open add booking form (Dialog or BottomSheet)
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
