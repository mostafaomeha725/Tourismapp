import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class BookingsDateSection extends StatelessWidget {
  final DateTime now;
  final DateTime fiveYearsLater;
  final DateTime shownDate;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDaySelected;

  const BookingsDateSection({
    super.key,
    required this.now,
    required this.fiveYearsLater,
    required this.shownDate,
    required this.selectedDate,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Select Date', style: font16w500),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 6.r,
                spreadRadius: 2.r,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TableCalendar(
            firstDay: now,
            lastDay: fiveYearsLater,
            focusedDay: shownDate,
            selectedDayPredicate: (day) =>
                selectedDate != null && isSameDay(selectedDate!, day),
            onDaySelected: (selectedDay, focusedDay) {
              onDaySelected(selectedDay);
            },
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color(0xff134FA2),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(color: Colors.black),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
        ),
      ],
    );
  }
}
