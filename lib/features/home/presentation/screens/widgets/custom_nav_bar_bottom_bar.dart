import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/nav_bar_item.dart';

class CustomNavBarBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomNavBarBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavBarItem(
            icon: Icons.place_outlined,
            isSelected: selectedIndex == 0,
            onTap: () => onItemTapped(0),
            label: 'Tourist places',
          ),
          NavBarItem(
            icon: Icons.design_services_outlined,
            isSelected: selectedIndex == 1,
            onTap: () => onItemTapped(1),
            label: 'Services',
          ),
          NavBarItem(
            icon: Icons.chat_bubble_outline,
            isSelected: selectedIndex == 2,
            onTap: () => onItemTapped(2),
            label: 'Helper',
          ),
          NavBarItem(
            icon: Icons.person_outline,
            isSelected: selectedIndex == 3,
            onTap: () => onItemTapped(3),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
