import 'package:dr_dental/core/app_export.dart';
import 'package:dr_dental/core/theme/app_colors.dart';
import 'package:dr_dental/core/theme/text_themes.dart';
import 'package:dr_dental/widgets/empty.dart';
import 'package:dr_dental/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/calender.dart';
import '../../../../../widgets/share_error_animation.dart';
import '../../../../user/user_card.dart';
import '../logic/add_patient_cubit.dart';

class AllPatients extends StatelessWidget {
  const AllPatients({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<BookPatientCubit>();

    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: Column(
        children: [
          cubit.selectionMode
              ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffEAF2FF),
                        borderRadius: BorderRadius.circular(20.0.h),
                      ),
                      child: IconButton(
                        onPressed: () {
                          showStyledDatePickerDialog(context);
                        },
                        icon: Icon(Icons.add, color: Colors.blue),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 40, // ارتفاع الخط العمودي
                    child: const VerticalDivider(
                      color: Colors.grey,
                      thickness: 2,
                      width: 20,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFFEEEF),
                        borderRadius: BorderRadius.circular(20.0.h),
                      ),
                      child: IconButton(
                        onPressed: () {
                          print(cubit.selectedPatients.last.age);
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40, // ارتفاع الخط العمودي
                    child: const VerticalDivider(
                      color: Colors.grey,
                      thickness: 2,
                      width: 20,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffF8F9FD),
                        borderRadius: BorderRadius.circular(20.0.h),
                      ),
                      child: IconButton(
                        onPressed: () {
                          cubit.clearSelection();
                        },
                        icon: Icon(Icons.close, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              )
              : TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[150],
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0.h),
                  ),
                  labelText: 'Search',
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
          SizedBox(height: 15.h),
          BlocConsumer<BookPatientCubit, BookPatientState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetAllPatientsLoading) {
                return Center(child: LoadingShared());
              } else if (state is GetAllPatientsFAil) {
                return Center(child: ErrorShared());
              } else if (cubit.patients.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      EmptyListShared(),
                      SizedBox(height: 10.h),
                      Text(
                        "No Users Found",
                        style: TextThemes.font22BlackMedium.copyWith(
                          color: AppColors.mainBlueColor,
                        ),
                      ),
                    ],
                  ),
                );
              }

              // لو فيه بيانات
              return Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 80.h),
                  itemCount: cubit.patients.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {
                        cubit.toggleSelectionMode(true);
                        cubit.togglePatientSelection(cubit.patients[index]);
                      },
                      onTap: () {
                        if (cubit.selectionMode) {
                          cubit.togglePatientSelection(cubit.patients[index]);
                        }
                      },
                      child: SizedBox(
                        height: 100.h,
                        child: Row(
                          children: [
                            if (cubit.selectionMode)
                              Checkbox(
                                value: cubit.selectedPatients.contains(cubit.patients[index]),
                                onChanged: (_) {
                                  cubit.togglePatientSelection(cubit.patients[index]);
                                },
                              ),
                            Expanded(
                              child: PatientCard(
                                name: cubit.patients[index].name,
                                age: cubit.patients[index].age,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 5.h),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
