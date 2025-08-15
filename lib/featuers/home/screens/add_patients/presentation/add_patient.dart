import 'package:cherry_toast/cherry_toast.dart';
import 'package:dr_dental/core/app_export.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/text_themes.dart';
import '../../../../../widgets/SharedTextFormField.dart';
import '../../../../../widgets/loading_widget.dart';
import '../logic/add_new_patient_cubit.dart';

class AddPatientScreen extends StatelessWidget {
  AddPatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<AddNewPatientCubit>();
    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Patient Name",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainBlueColor,
              ),
            ),
            SizedBox(height: 15.h),
            SharedTextFormField(
              hintText: "Enter Patient Name",
              validator: (validator) {
                if (validator!.isEmpty) {
                  return "please Enter Patient Name";
                }
                return null;
              },
              keyboardType: TextInputType.name,
              controller: cubit.name,
            ),
            SizedBox(height: 20.h),
            Text(
              "Patient Phone Number",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainBlueColor,
              ),
            ),
            SizedBox(height: 15.h),
            SharedTextFormField(
              maxLength: 11,
              hintText: "Enter Patient Phone Number",
              validator: (validator) {
                if (validator!.isEmpty) {
                  return "please Enter Patient Phone Number";
                }
                return null;
              },
              controller: cubit.phone,
              keyboardType: TextInputType.phone,
            ),

            SizedBox(height: 25.h),
            Text(
              "Patient AGE",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainBlueColor,
              ),
            ),
            SizedBox(height: 15.h),
            SharedTextFormField(
              maxLength: 2,
              hintText: "Enter Patient AGE",
              validator: (validator) {
                if (validator!.isEmpty) {
                  return "please Enter Patient AGE";
                }
                return null;
              },
              controller: cubit.age,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 25.h),
            Text(
              "Enter Patient Address",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainBlueColor,
              ),
            ),
            SizedBox(height: 15.h),
            SharedTextFormField(
              hintText: "Enter Patient Address",
              validator: (validator) {
                if (validator!.isEmpty) {
                  return "please Enter Patient Address";
                }
                return null;
              },
              controller: cubit.address,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 25.h),
            Text(
              "Select Patient Gender",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainBlueColor,
              ),
            ),
            SizedBox(height: 15.h),
            ListTile(
              title: Text("male"),
              leading: Radio<String>(
                value: "male",
                groupValue: cubit.selectedGender, //cubit.selectedGender,
                onChanged: (value) {
                  cubit.changeGender(value!);
                },
              ),
            ),
            ListTile(
              title: Text("female"),
              leading: Radio<String>(
                value: "female",
                groupValue: cubit.selectedGender, //cubit.selectedGender,
                onChanged: (value) {
                  cubit.changeGender(value!);
                },
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              height: 50.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.mainBlueColor,
                borderRadius: BorderRadius.circular(10.h),
              ),
              child: MaterialButton(
                onPressed: () {
                  cubit.addPatient();
                },
                child: Text(
                  "Add Patient",
                  style: TextThemes.font16BlackBold.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            BlocListener<AddNewPatientCubit,AddNewPatientState>(listener: (BuildContext context, state) {
              if(state is AddPatientSuccess){
                Navigator.pop(context);
                CherryToast.success(
                  title: Text(
                    "Add Patient  successfully",
                    style: TextStyle(color: Colors.black),
                  ),
                ).show(context);

              }
              if(state is AddPatientFailure){
                Navigator.pop(context);
                CherryToast.error(
                  title: Text(
                    "Error to Add Patient Try Again",
                    style: TextStyle(color: Colors.black),
                  ),
                ).show(context);

              }
              if(state is AddPatientLoading){
                showDialog(context: context, builder: (context) {
                  return LoadingShared();
                });
              }
            },
            child: SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
