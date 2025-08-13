import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:dr_dental/core/app_export.dart';
import 'package:dr_dental/core/helpers/extentions/context_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../core/const/const.dart';
import '../../login_screen/logic/login_cubit.dart';
import '../../user/user_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<_NavItem> _items = [
    _NavItem(icon: Icons.people, label: 'Patients'),
    _NavItem(icon: Icons.calendar_today, label: 'Appts'),
    _NavItem(icon: Icons.self_improvement, label: 'Sessions'),
  ];
  final _pageController = PageController(initialPage: 0);
  final NotchBottomBarController _controller = NotchBottomBarController(
    index: 0,
  );

  DateTime _currentDate = DateTime.now();
  EventList<Event> _markedDateMap = EventList<Event>(events: {});

  void _onTap(int index) {
    setState(() => _selectedIndex = index);
    // placeholder: Navigator.pushNamed(...) or setState to change body
  }

  static Widget _eventIcon = Container(
    decoration: BoxDecoration(
      color: Colors.yellow,
      borderRadius: BorderRadius.circular(1000),
    ),
    child: Center(child: Icon(Icons.person, color: Colors.white)),
  );

  @override
  void initState() {
    super.initState();
    _markedDateMap.add(
      DateTime.now(),
      Event(date: DateTime.now(), title: 'Today\'s Event', icon: _eventIcon),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Background to make the glass effect visible
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 13.0.h, right: 13.0.h),
          child: Column(
            children: [
              Container(
                height: 50.h,
                width: double.infinity,
                child: Row(
                  children: [
                    Spacer(),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        var cubit = context.read<LoginCubit>();
                        return Column(
                          children: [
                            CircleAvatar(
                              radius: 20.h,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  cubit.logOut();
                                },
                                icon: Icon(
                                  Icons.exit_to_app,
                                  color: Colors.red,
                                  size: 25.h,
                                ),
                              ),
                            ),
                            BlocListener<LoginCubit, LoginState>(
                              listener: (
                                BuildContext context,
                                LoginState state,
                              ) {
                                if (state is LogOut) {
                                  context.pushAndRemoveUntil(loginScreen);
                                }
                              },
                              child: SizedBox(),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              CalendarCarousel<Event>(
                onDayPressed: (DateTime date, List<Event> events) {
                  setState(() => _currentDate = date);
                  print((_currentDate.toString()).split(' ')[0]);
                  print(events.length);
                },
                weekendTextStyle: TextStyle(color: Colors.red),
                thisMonthDayBorderColor: Colors.grey,
                selectedDateTime: _currentDate,
                markedDatesMap: _markedDateMap,
                height: 400.h,
                selectedDayButtonColor: Colors.blue,
                selectedDayBorderColor: Colors.blueAccent,
              ),
              SizedBox(height: 20.h),
              Divider(height: 4.h, thickness: 1),
              SizedBox(height: 20.h),

              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 80.h),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 100.h,
                      child: PatientCard(
                        name: "abdo fekry",
                        age: "30",
                        diagnosis: "asdasdbkasdasdbadkhabdkhasbd",
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 5.h);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GNav(
        mainAxisAlignment: MainAxisAlignment.center,
        backgroundColor: Colors.white,
        rippleColor: Colors.white,
        // tab button ripple color when pressed
        hoverColor: Colors.white,
        // tab button hover color
        haptic: true,
        // haptic feedback
        tabBorderRadius: 50.h,
        //tabActiveBorder: Border.all(color: Colors.blue, width: 1),
        // tab button border
        tabBorder: Border.all(color: Colors.white, width: 1),
        // tab button border
        tabShadow: [
          //BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8),
        ],
        // tab button shadow
        curve: Curves.easeInSine,
        // tab animation curves
        duration: Duration(milliseconds: 500),
        // tab animation duration
        gap: 4,
        // the tab button gap between icon and text
        color: Colors.grey[800],
        // unselected icon color
        activeColor: Colors.blue,
        // selected icon and text color
        iconSize: 20,
        // tab button icon size
        padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 14.h),
        // navigation bar padding
        tabs: [
          GButton(icon: Icons.home, text: _items[0].label,backgroundColor: Colors.white,),
          GButton(icon: Icons.favorite, text: _items[1].label,backgroundColor: Colors.white,),
          GButton(icon: Icons.search, text:_items[2].label,backgroundColor: Colors.white,),
        ],
      ), // Floating bottom navigation using LiquidGlass
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  _NavItem({required this.icon, required this.label});
}
