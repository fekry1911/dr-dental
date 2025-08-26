import 'package:dr_dental/core/app_export.dart';
import 'package:dr_dental/core/helpers/extentions/context_extention.dart';
import 'package:dr_dental/core/theme/app_colors.dart';
import 'package:dr_dental/core/theme/text_themes.dart';
import 'package:dr_dental/widgets/empty.dart';
import 'package:dr_dental/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../core/const/const.dart';
import '../../../../../widgets/share_error_animation.dart';
import '../../../../../widgets/awesome_loading.dart';
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
          Container(
            margin: EdgeInsets.only(bottom: 10.h),
            child: TextFormField(
              cursorColor: AppColors.mainBlueColor,
              decoration: InputDecoration(

                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,

                  borderRadius: BorderRadius.circular(10.0.h),
                ),
                hintText: 'Search',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0.h),

                  borderSide: BorderSide(
                    color: Colors.blue, // لون الـ border عند التركيز (focus)

                  ),),

                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                cubit.searchPatients(value);
              },
            ).animate().flipV(duration: 1000.ms),
          ),
          SizedBox(height: 15.h),

          Expanded(
            flex: 24,
            child: BlocConsumer<BookPatientCubit, BookPatientState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is GetAllPatientsLoading) {
                  return LoadingShared();
                } else if (cubit.patients.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                  );
                } else if (state is GetAllPatientsFAil) {
                  return ErrorShared();
                }

                return ListView.separated(
                  itemCount: cubit.patients.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(
                          patientScreen,
                          arguments: cubit.patients[index].id,
                        );
                      },
                      child: PatientCard(
                        name: cubit.patients[index].name,
                        ageGender: "${cubit.patients[index].age} , ${cubit.patients[index].gender}",
                        phone: cubit.patients[index].phone,
                        address: cubit.patients[index].address,
                      ),
                    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.2, end: 0.0);

                  },
                  separatorBuilder: (context, index) => SizedBox(height: 5.h),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
