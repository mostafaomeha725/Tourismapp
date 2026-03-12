import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/active_chip.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/filter_bottom_sheet.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/filter_option.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/filter_tap.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/open_map.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/service_item.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/tourism_card.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  String _selectedFilter = "All";
  FilterOptions _filterOptions = const FilterOptions(
    budgetRange: RangeValues(0, 300),
  );

  bool get _hasActiveFilters =>
      _filterOptions.selectedCity != null ||
      _filterOptions.budgetRange.start > 0 ||
      _filterOptions.budgetRange.end < 300;

  List<ServiceItem> get _filteredList {
    return allServices.where((item) {
      final matchCategory =
          _selectedFilter == "All" || item.category == _selectedFilter;
      final matchCity =
          _filterOptions.selectedCity == null ||
          item.city == _filterOptions.selectedCity;
      final matchBudget =
          item.price >= _filterOptions.budgetRange.start &&
          item.price <= _filterOptions.budgetRange.end;
      return matchCategory && matchCity && matchBudget;
    }).toList();
  }

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: FilterBottomSheet(
          initialOptions: _filterOptions,
          onApply: (options) {
            setState(() => _filterOptions = options);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredList;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.h),

              AppText(
                'Distinctive tourism services',
                style: font20w700,
                overflow: TextOverflow.visible,
              ),
              SizedBox(height: 4.h),
              AppText(
                'Book guides, photographers, and tours',
                overflow: TextOverflow.visible,
                style: font14w400.copyWith(color: Colors.grey[600]),
              ),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: _openFilterSheet,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: _hasActiveFilters
                        ? const Color(0xffdb6000)
                        : const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.tune_rounded,
                        size: 18.sp,
                        color: _hasActiveFilters
                            ? Colors.white
                            : Colors.black87,
                      ),
                      SizedBox(width: 8.w),
                      AppText(
                        'Filter',
                        style: font14w700.copyWith(
                          color: _hasActiveFilters
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                      if (_hasActiveFilters) ...[
                        SizedBox(width: 6.w),
                        Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              if (_hasActiveFilters) ...[
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 8.w,
                    runSpacing: 6.h,
                    children: [
                      if (_filterOptions.selectedCity != null)
                        ActiveChip(
                          label: _filterOptions.selectedCity!,
                          icon: Icons.location_on_outlined,
                          onRemove: () => setState(() {
                            _filterOptions = _filterOptions.copyWith(
                              clearCity: true,
                            );
                          }),
                        ),
                      if (_filterOptions.budgetRange.start > 0 ||
                          _filterOptions.budgetRange.end < 300)
                        ActiveChip(
                          label:
                              '\$${_filterOptions.budgetRange.start.toInt()} – \$${_filterOptions.budgetRange.end.toInt()}',
                          icon: Icons.attach_money,
                          onRemove: () => setState(() {
                            _filterOptions = _filterOptions.copyWith(
                              budgetRange: const RangeValues(0, 300),
                            );
                          }),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
              ],

              FilterTabs(
                selectedFilter: _selectedFilter,
                onFilterChanged: (newFilter) {
                  setState(() => _selectedFilter = newFilter);
                },
              ),

              SizedBox(height: 16.h),

              if (filtered.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 60.h),
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 56.sp,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 12.h),
                      AppText(
                        'No results found',
                        style: font16w700.copyWith(color: Colors.grey[500]),
                        alignment: AlignmentDirectional.center,
                      ),
                      SizedBox(height: 6.h),
                      AppText(
                        'Try adjusting your filters',
                        style: font14w400.copyWith(color: Colors.grey[400]),
                        alignment: AlignmentDirectional.center,
                      ),
                    ],
                  ),
                )
              else
                ...filtered.map((item) {
                  return TourismCard(
                    text: item.category,
                    imageUrl: item.imageUrl,
                    title: item.title,
                    description: item.description,
                    location: item.location,
                    isicon: true,
                    icon: item.icon,
                    price: item.price,
                    onViewMap: () => openLocationLink(item.mapUrl),
                    onBook: () =>
                        GoRouter.of(context).push(Routes.bookDetailsScreen),
                  );
                }),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
