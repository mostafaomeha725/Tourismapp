import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class BookingsTimeSlotsSection extends StatelessWidget {
  final List<String> timeSlots;
  final String? selectedTime;
  final ValueChanged<String> onTimeSelected;

  const BookingsTimeSlotsSection({
    super.key,
    required this.timeSlots,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Select Time', style: font16w500),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 10.h,
          children: timeSlots.map((time) {
            final bool isSelected = selectedTime == time;
            return GestureDetector(
              onTap: () => onTimeSelected(time),
              child: Container(
                width: 100.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xff134FA2)
                      : Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8.r),
                  border: isSelected
                      ? Border.all(color: const Color(0xff0b3a7a))
                      : null,
                ),
                child: AppText(
                  time,
                  style: font12w500.copyWith(
                    color: isSelected ? Colors.white : const Color(0xff134FA2),
                  ),
                  alignment: AlignmentDirectional.center,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
