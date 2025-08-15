import 'package:dr_dental/core/app_export.dart';
import 'package:dr_dental/core/helpers/extentions/context_extention.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../core/const/const.dart';
import '../../login_screen/logic/login_cubit.dart';
import '../logic/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Background to make the glass effect visible
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.watch<HomeCubit>(); // بدل read بـ watch
        return SafeArea(
          top: false,
          left: false,
          right: false,
          bottom: true,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(cubit.titles[cubit.index]),
            ),
            extendBody: true,
            body: cubit.screens[cubit.index],

            bottomNavigationBar: GNav(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              backgroundColor: Colors.white,
              rippleColor: Colors.blue.withOpacity(0.2),
              hoverColor: Colors.blue.withOpacity(0.1),
              haptic: true,
              gap: 8,
              activeColor: Colors.white,
              color: Colors.grey[600],
              iconSize: 26,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.blue.withOpacity(0.2),
              tabBorderRadius: 15,
              selectedIndex: cubit.index,
              onTabChange: (index) {
                cubit.changeIndex(index);
              },
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                  iconActiveColor: Colors.blue,
                  textColor: Colors.blue,
                ),
                GButton(
                  icon: Icons.favorite,
                  text: "Patients",
                  iconActiveColor: Colors.blue,
                  textColor: Colors.blue,
                ),
                GButton(
                  icon: Icons.search,
                  text: "Reports",
                  iconActiveColor: Colors.blue,
                  textColor: Colors.blue,
                ),
              ],
            )
            ,
            // Floating bottom navigation using LiquidGlass
            floatingActionButton:
                cubit.index == 0
                    ? FloatingActionButton(
                      onPressed: () {},
                      child: Icon(Icons.add, color: Colors.white),
                      backgroundColor: Colors.blue,
                    )
                    : null,
          ),
        );
      },
    );
  }
}
