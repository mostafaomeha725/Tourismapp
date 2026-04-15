import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/bookings_date_section.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/bookings_time_slots_section.dart';

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
            BookingsDateSection(
              now: now,
              fiveYearsLater: fiveYearsLater,
              shownDate: shownDate,
              selectedDate: _selectedDate,
              onDaySelected: (selectedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                });
              },
            ),

            SizedBox(height: 20.h),
            BookingsTimeSlotsSection(
              timeSlots: _timeSlots,
              selectedTime: _selectedTime,
              onTimeSelected: (time) {
                setState(() {
                  _selectedTime = time;
                });
              },
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
