import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/booking_card.dart';

class BookingListConfirmed extends StatelessWidget {
  const BookingListConfirmed({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      children: [
        BookingCard(
          title: "Tour Guide - Pyramids",
          image: Assets.egyptsplash,
          date: "Dec 15, 2024",
          price: "50",
          status: "confirmed",
        ),
        SizedBox(height: 16.h),
        BookingCard(
          title: "Nile Cruise Dinner",
          image: Assets.karnak,
          date: "Jan 20, 2025",
          price: "120",
          status: "confirmed",
        ),
        SizedBox(height: 16.h),
        BookingCard(
          title: "Nile Cruise Dinner",
          image: Assets.egyptsplash,
          date: "Jan 20, 2025",
          price: "120",
          status: "confirmed",
        ),
      ],
    );
  }
}
