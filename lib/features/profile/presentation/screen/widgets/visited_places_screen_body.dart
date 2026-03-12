import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/visited_places_card.dart';

class VisitedPlacesScreenBody extends StatelessWidget {
  const VisitedPlacesScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> visitedPlaces = [
      {
        "title": "The Pyramids of Giza",
        "date": "Nov 10, 2024",
        "image": Assets.egyptsplash,
        "rating": 5.0,
      },
      {
        "title": "Louvre Museum",
        "date": "Oct 15, 2024",
        "image": Assets.karnak,
        "rating": 3.0,
      },
      {
        "title": "Burj Khalifa",
        "date": "Sep 01, 2024",
        "image": Assets.egyptsplash,
        "rating": 5.0,
      },
      {
        "title": "The Pyramids of Giza",
        "date": "Nov 10, 2024",
        "image": Assets.egyptsplash,
        "rating": 5.0,
      },
      {
        "title": "Louvre Museum",
        "date": "Oct 15, 2024",
        "image": Assets.karnak,
        "rating": 3.0,
      },
      {
        "title": "Burj Khalifa",
        "date": "Sep 01, 2024",
        "image": Assets.egyptsplash,
        "rating": 5.0,
      },
      {
        "title": "The Pyramids of Giza",
        "date": "Nov 10, 2024",
        "image": Assets.egyptsplash,
        "rating": 5.0,
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: ListView.separated(
        // physics: const BouncingScrollPhysics(),
        itemCount: visitedPlaces.length,
        separatorBuilder: (context, index) => SizedBox(height: 22.h),
        itemBuilder: (context, index) {
          final place = visitedPlaces[index];
          return VisitedPlaceCard(
            title: place['title'],
            date: place['date'],
            image: place['image'],
            rating: place['rating'],
          );
        },
      ),
    );
  }
}
