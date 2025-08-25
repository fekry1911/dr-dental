import 'package:dr_dental/core/helpers/extentions/context_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../../../../../core/app_export.dart';
import '../../../../../core/const/const.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/text_themes.dart';
import '../../../../../widgets/empty.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../../widgets/share_error_animation.dart';
import '../../../../user/user_card.dart';
import '../logic/gtpatientday_cubit.dart';

class AppptsScreen extends StatelessWidget {
  AppptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetpatientdayCubit, GetpatientdayState>(
      builder: (context, state) {
        var cubit = context.read<GetpatientdayCubit>();
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 13.0.h, right: 13.0.h),
            child: Column(
              children: [
                CalendarCarousel<Event>(
                  onDayPressed: (DateTime date, List<Event> events) {
                    String formatted =
                        "${date!.year}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}";

                    cubit.changeDate(date);
                    cubit.getPatientsOfDay(formatted).then((va) {
                      print(cubit.patients);
                    });
                  },
                  weekendTextStyle: TextStyle(color: Colors.red),
                  thisMonthDayBorderColor: Colors.grey,
                  selectedDateTime: cubit.currentDate,
                  height: 400.h,

                  selectedDayButtonColor: Colors.blue,
                  selectedDayBorderColor: Colors.blueAccent,
                ),
                SizedBox(height: 20.h),
                Divider(height: 4.h, thickness: 1),
                SizedBox(height: 20.h),

                Expanded(
                  child: BlocConsumer<GetpatientdayCubit, GetpatientdayState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is GtpatientdayLoading) {
                        return Center(child: LoadingShared());
                      } else if (state is GtpatientdayFailure) {
                        return Center(child: ErrorShared());
                      } else if (cubit.patients.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              Container(
                                height: 200.h,
                                width: 200.h,
                                child: EmptyListShared(),
                              ),
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
                            return SizedBox(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        context.pushNamed(
                                          patientScreen,
                                          arguments: cubit.patients[index].id,
                                        );
                                      },
                                      child: PatientCard(
                                        name: cubit.patients[index].name,
                                        ageGender: "${cubit.patients[index].age} , ${cubit.patients[index].gender}",
                                        phone:cubit.patients[index].phone,
                                        address:cubit.patients[index].address,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder:
                              (context, index) => SizedBox(height: 5.h),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
