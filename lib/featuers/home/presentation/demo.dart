import 'package:dr_dental/core/app_export.dart';
import 'package:dr_dental/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../logic/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.watch<HomeCubit>();

        return SafeArea(
          top: false,
          left: false,
          right: false,
          bottom: true,
          child: Scaffold(
            backgroundColor: AppColors.secondryColor,
            appBar: AppBar(
              backgroundColor: AppColors.secondryColor,
              elevation: 0,
              title: Text(
                cubit.titles[cubit.index],
                style: TextStyle(
                  color: AppColors.mainBlueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            extendBody: true,
            body: cubit.screens[cubit.index],

            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color:    AppColors.secondryColor,

              boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: GNav(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    rippleColor: AppColors.mainBlueColor.withOpacity(0.2),
                    hoverColor: AppColors.mainBlueColor.withOpacity(0.1),
                    haptic: true,
                    gap: 8,
                    activeColor: Colors.white,
                    color: Colors.grey[600],
                    iconSize: 26,
                    backgroundColor: AppColors.secondryColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    duration: Duration(milliseconds: 400),
                    tabBackgroundColor: AppColors.mainBlueColor.withOpacity(0.2),
                    tabBorderRadius: 15,
                    selectedIndex: cubit.index,
                    onTabChange: (index) => cubit.changeIndex(index),
                    tabs: [
                      GButton(
                        icon: Icons.home,
                        text: "Home",
                        iconActiveColor: AppColors.mainBlueColor,
                        textColor: AppColors.mainBlueColor,
                      ),
                      GButton(
                        icon: Icons.group,
                        text: "Patients",
                        iconActiveColor: AppColors.mainBlueColor,
                        textColor: AppColors.mainBlueColor,
                      ),
                      GButton(
                        icon: Icons.add,
                        text: "Add Patient",
                        iconActiveColor: AppColors.mainBlueColor,
                        textColor: AppColors.mainBlueColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
