import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/filter_item_widget.dart';

class FilterTabs extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;
  final List<String> filters;

  const FilterTabs({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.filters,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = filters;

    return Container(
      padding: EdgeInsets.all(6.r),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2F6),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.map((tab) {
            return Padding(
              padding: EdgeInsetsDirectional.only(end: 6.w),
              child: FilterItemWidget(
                title: tab,
                icon: null,
                isSelected: selectedFilter == tab,
                onTap: () => onFilterChanged(tab),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
