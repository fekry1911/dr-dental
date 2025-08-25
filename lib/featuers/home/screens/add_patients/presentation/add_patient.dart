import 'package:cherry_toast/cherry_toast.dart';
import 'package:dr_dental/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/text_themes.dart';
import '../../../../../widgets/SharedTextFormField.dart';
import '../../../../../widgets/awesome_loading.dart';
import '../../../../../widgets/loading_widget.dart';
import '../logic/add_new_patient_cubit.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen>
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
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<AddNewPatientCubit>();

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 8.0.h,
              right: 8.0.h,
              top: 8.0.h,
              bottom: MediaQuery.of(context).viewInsets.bottom + 8.h,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        SizedBox(height: 15.h),
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
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 15.h),
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
                          keyboardType: TextInputType.streetAddress,
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
                            groupValue: cubit.selectedGender,
                            onChanged: (value) {
                              cubit.changeGender(value!);
                            },
                          ),
                        ),
                        ListTile(
                          title: Text("female"),
                          leading: Radio<String>(
                            value: "female",
                            groupValue: cubit.selectedGender,
                            onChanged: (value) {
                              cubit.changeGender(value!);
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),
                        ScaleTransition(
                          scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                            CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
                          ),
                          child: Container(
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
                        ),
                        // BlocListener
                        BlocListener<AddNewPatientCubit, AddNewPatientState>(
                          listener: (BuildContext context, state) {
                            if (state is AddPatientSuccess) {
                              Navigator.pop(context);
                              CherryToast.success(
                                title: Text(
                                  "Add Patient successfully",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ).show(context);
                            }
                            if (state is AddPatientFailure) {
                              Navigator.pop(context);
                              CherryToast.error(
                                title: Text(
                                  "Error to Add Patient. Try Again",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ).show(context);
                            }
                            if (state is AddPatientLoading) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return LoadingWidget();
                                },
                              );
                            }
                          },
                          child: SizedBox(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
