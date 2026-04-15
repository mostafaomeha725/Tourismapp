import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNavBarBodyStack extends StatelessWidget {
  final int selectedIndex;
  final List<Widget> screens;
  final Animation<double> fabPulse;
  final VoidCallback onEmergencyTap;

  const CustomNavBarBodyStack({
    super.key,
    required this.selectedIndex,
    required this.screens,
    required this.fabPulse,
    required this.onEmergencyTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isProfileScreen = selectedIndex == 3;

    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: screens[selectedIndex],
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          bottom: isProfileScreen ? -100.h : 40.h,
          left: 22.w,
          child: GestureDetector(
            onTap: onEmergencyTap,
            child: AnimatedBuilder(
              animation: fabPulse,
              builder: (context, child) {
                return Opacity(
                  opacity: fabPulse.value,
                  child: Container(
                    padding: EdgeInsets.all(16.h),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 8.r),
                      ],
                    ),
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
