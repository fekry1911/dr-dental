import 'package:dr_dental/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class LiquidBottomNavExample extends StatefulWidget {
  @override
  _LiquidBottomNavExampleState createState() => _LiquidBottomNavExampleState();
}

class _LiquidBottomNavExampleState extends State<LiquidBottomNavExample> {
  int _selectedIndex = 0;
  final List<_NavItem> _items = [
    _NavItem(icon: Icons.people, label: 'Patients'),
    _NavItem(icon: Icons.calendar_today, label: 'Appts'),
    _NavItem(icon: Icons.self_improvement, label: 'Sessions'),
    _NavItem(icon: Icons.payment, label: 'Payments'),
    _NavItem(icon: Icons.bar_chart, label: 'Reports'),
  ];

  void _onTap(int index) {
    setState(() => _selectedIndex = index);
    // placeholder: Navigator.pushNamed(...) or setState to change body
  }

  @override
  Widget build(BuildContext context) {
    // Background to make the glass effect visible
    return Scaffold(
      extendBody: true, // important so bottom nav floats over content
      body: Stack(
        children: [
          // Example background - replace with your actual screen content
          Positioned.fill(
            child: Image.network(
              'https://picsum.photos/800/1400?blur=2',
              fit: BoxFit.cover,
            ),
          ),

          // Main content placeholder
          Positioned.fill(
            child: Center(
              child: Text(
                'Dr.Clinic — ${_items[_selectedIndex].label}',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        ],
      ),

      // Floating bottom navigation using LiquidGlass
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.0.h
            , vertical: 10.h),
        child: LiquidGlass(
          // shape and appearance
          shape: LiquidRoundedSuperellipse(borderRadius: Radius.circular(20)),
          settings: const LiquidGlassSettings(
            blur: 6.0,
            glassColor: Color(0x33FFFFFF),
          ),            glassContainsChild: false, // child on top (so icons are crisp)
          child: Container(
            height: 72.h,
            padding:  EdgeInsets.symmetric(horizontal: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_items.length, (index) {
                final item = _items[index];
                final isSelected = index == _selectedIndex;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => _onTap(index),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon with subtle background for selected state
                        Container(
                          padding:  EdgeInsets.all(8.h),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? Colors.blue.withOpacity(0.15)
                                : Colors.transparent,
                          ),
                          child: Icon(
                            item.icon,
                            size: 25.fSize,
                            color: isSelected ? Colors.blueAccent : Colors.white,
                          ),
                        ),
                         SizedBox(height: 6.h),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 11.fSize,
                            color: isSelected ? Colors.blueAccent : Colors.white70,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          // Optional settings: you can also pass LiquidGlassSettings for more control
          // settings: const LiquidGlassSettings(thickness: 8, glassColor: Color(0x33FFFFFF)),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  _NavItem({required this.icon, required this.label});
}
