import 'package:dr_dental/core/theme/app_colors.dart';
import 'package:dr_dental/featuers/home/screens/patients/data/model/booking_model.dart';
import 'package:dr_dental/featuers/user/logic/patient_data_cubit.dart';
import 'package:dr_dental/featuers/user/presentation/widgets/bottom_sheet.dart';
import 'package:dr_dental/featuers/user/presentation/widgets/calender.dart';
import 'package:dr_dental/featuers/user/presentation/widgets/last_session.dart';
import 'package:dr_dental/widgets/loading_widget.dart';
import 'package:dr_dental/widgets/share_error_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../core/app_export.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondryColor,
      ),
      body: Container(
        color: AppColors.secondryColor, // خلفية هادية
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocConsumer<PatientDataCubit, PatientDataState>(
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

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Patient Info
                      Text(
                        "Name: ${cubit.patientModel!.name}",
                        style: TextStyle(
                            fontSize: 20.fSize, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Phone: ${cubit.patientModel!.phone}",
                        style: TextStyle(
                            fontSize: 18.fSize, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Last Session",
                        style: TextStyle(
                            fontSize: 20.fSize, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12.h),
                      lastSession == null || lastSession.reason == "reason"
                          ? const Center(child: Text("No last session available"))
                          : FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                              position: _slideAnimation,
                              child:
                              LastSessionAnimated(booking: lastSession))),
                      SizedBox(height: 20.h),
                      Text(
                        "Appointments",
                        style: TextStyle(
                            fontSize: 20.fSize, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12.h),
                      cubit.bookings.isEmpty
                          ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("No bookings found 🗓️",
                              style: TextStyle(fontSize: 16)),
                        ),
                      )
                          : Column(
                        children: List.generate(
                          cubit.bookings.length,
                              (index) {
                            final item = cubit.bookings[index];
                            return FadeTransition(
                              opacity: _fadeAnimation,
                              child: SlideTransition(
                                position: _slideAnimation,
                                child: TimelineTile(
                                  alignment: TimelineAlign.start,
                                  isFirst: index == 0,
                                  isLast:
                                  index == cubit.bookings.length - 1,
                                  indicatorStyle: IndicatorStyle(
                                    width: 20,
                                    color: index == 0
                                        ? Colors.blueAccent
                                        : Colors.grey[400]!,
                                    padding: const EdgeInsets.all(6),
                                  ),
                                  beforeLineStyle: const LineStyle(
                                      color: Colors.grey, thickness: 2),
                                  afterLineStyle: const LineStyle(
                                      color: Colors.grey, thickness: 2),
                                  endChild: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade200,
                                            blurRadius: 4,
                                            offset: const Offset(0, 2))
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${item.day} | ${item.time}",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color:
                                                    Colors.blueAccent),
                                              ),
                                              const SizedBox(height: 8),
                                              Container(
                                                padding:
                                                const EdgeInsets.all(10),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors
                                                      .blueGrey[50],
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(12),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "📌 ${item.reason ?? ""}",
                                                      style: const TextStyle(
                                                          color: Colors
                                                              .black54),
                                                    ),
                                                    if (item.note != null &&
                                                        item.note!
                                                            .isNotEmpty) ...[
                                                      SizedBox(
                                                          height: 4.h),
                                                      Text(
                                                        "📝 Note: ${item.note}",
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .black45,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  cubit
                                                      .deletePatientAppointments(
                                                    cubit.patientModel!.id!,
                                                    cubit.bookings[index]
                                                        .id!,
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: index == 0
                                                    ? () {
                                                  showEditProfileBottomSheet(
                                                      context);
                                                }
                                                    : null,
                                                icon: Icon(
                                                  index == 0
                                                      ? Icons.edit
                                                      : Icons.check,
                                                  color: index !=
                                                      cubit.bookings
                                                          .length -
                                                          1
                                                      ? Colors.blue
                                                      : Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
                      // Add Appointment Button
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: GestureDetector(
                              onTapDown: (_) => _controller.reverse(),
                              onTapUp: (_) {
                                _controller.forward();
                                showStyledDatePickerDialogData(
                                    context, cubit.patientModel!);
                              },
                              child: ScaleTransition(
                                scale: Tween<double>(begin: 0.95, end: 1.0)
                                    .animate(CurvedAnimation(
                                    parent: _controller,
                                    curve: Curves.easeInOut)),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Add Appointment",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
