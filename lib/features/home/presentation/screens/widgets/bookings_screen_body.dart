import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class BookingsScreenBody extends StatefulWidget {
  const BookingsScreenBody({super.key});

  @override
  State<BookingsScreenBody> createState() => _BookingsScreenBodyState();
}

class _BookingsScreenBodyState extends State<BookingsScreenBody> {
  DateTime? _selectedDate;
  String? _selectedTime;

  final List<String> _timeSlots = const [
    "8:00 AM",
    "9:00 AM",
    "10:00 AM",
    "12:00 PM",
    "2:00 PM",
    "4:00 PM",
    "6:00 PM",
    "8:00 PM",
  ];

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime fiveYearsLater = DateTime(now.year + 5, now.month, now.day);

    final DateTime shownDate = _selectedDate ?? now;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),
            AppText("Select Date", style: font16w500),
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
                    _selectedDate != null && isSameDay(_selectedDate!, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDay;
                  });
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

            SizedBox(height: 20.h),
            AppText("Select Time", style: font16w500),
            SizedBox(height: 16.h),

            Wrap(
              spacing: 8.w,
              runSpacing: 10.h,
              children: _timeSlots.map((time) {
                final bool isSelected = _selectedTime == time;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTime = time;
                    });
                  },
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
                    child: Text(
                      time,
                      style: font12w500.copyWith(
                        color: isSelected
                            ? Colors.white
                            : const Color(0xff134FA2),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 32.h),

            AppButton(
              text: 'Next',
              onPressed: () {
                if (_selectedDate == null || _selectedTime == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        _selectedDate == null
                            ? 'Please select a date'
                            : 'Please select a time',
                      ),
                    ),
                  );

                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Selected: ${_selectedDate!.toLocal().toIso8601String().split("T").first} at $_selectedTime',
                    ),
                  ),
                );
                GoRouter.of(context).pop();
                GoRouter.of(context).pop();
              },
              color: const Color(0xffdb6000),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
