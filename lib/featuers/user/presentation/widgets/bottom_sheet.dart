
import 'package:dr_dental/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/const/const.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_themes.dart';
import '../../../../widgets/SharedTextFormField.dart';
import '../../logic/patient_data_cubit.dart';


void showEditProfileBottomSheet(BuildContext context) {
  final cubit = context.read<PatientDataCubit>();

  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true, // 👈 علشان الفورم يوسع مع الكيبورد
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return BlocProvider.value(
        value: cubit,
        child: BlocListener<PatientDataCubit, PatientDataState>(
          listener: (context, state) {},
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.h,
              right: 16.h,
              top: 16.h,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 5,
                  width: 40,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                Text(
                  'Session Details',
                  style: TextThemes.font18BlackSemiBold.copyWith(
                    color: AppColors.mainBlueColor,
                  ),
                ),
                SizedBox(height: 16.h),
                SharedTextFormField(
                  controller: cubit.reason,
                  maxLength: 22,
                  hintText: "reason",
                  validator: (value) {

                  },
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 10.h),
                SharedTextFormField(
                  controller: cubit.note,
                  maxLength: 11,
                  hintText: "note",
                  validator: (value) {

                  },
                  keyboardType: TextInputType.phone,
                ),
                SharedTextFormField(
                  controller: cubit.cost,
                  maxLength: 11,
                  hintText: "cost",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter phone";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
                SharedTextFormField(
                  controller: cubit.paid,
                  maxLength: 11,
                  hintText: "paid",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter phone";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextThemes.font16BlackBold.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const Spacer(),
                    MaterialButton(
                      color:AppColors.mainBlueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () {
                        cubit.noteTheSession(cubit.patientModel!.id!,cubit.bookings.first.id!);
                      },
                      child: Text(
                        'Save',
                        style: TextThemes.font16BlackBold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
