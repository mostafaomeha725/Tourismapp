import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/filter_item_widget.dart';

class FilterTabs extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const FilterTabs({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tabs = [
      {"title": "All", "icon": null},
      {"title": "Guides", "icon": Icons.person_outline},
      {"title": "Photographers", "icon": Icons.camera_alt_outlined},
      {"title": "Trips", "icon": Icons.location_on_outlined},
    ];

    return Container(
      padding: EdgeInsets.all(6.r),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2F6),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tabs.map((tab) {
          return FilterItemWidget(
            title: tab["title"],
            icon: tab["icon"],
            isSelected: selectedFilter == tab["title"],
            onTap: () => onFilterChanged(tab["title"]),
          );
        }).toList(),
      ),
    );
  }
}
