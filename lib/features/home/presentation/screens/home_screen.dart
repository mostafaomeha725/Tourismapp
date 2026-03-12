import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/open_map.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/tourism_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.onNavigateToTab});

  final Function(int)? onNavigateToTab;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.h),
              AppText('Discover Tourist Places', style: font20w700),
              SizedBox(height: 4.h),

              AppText(
                'Explore the most beautiful desations in Egypt',
                overflow: TextOverflow.visible,
                style: font14w400.copyWith(color: Colors.grey[600]),
              ),
              SizedBox(height: 16.h),
              TourismCard(
                text: 'archaeological',
                imageUrl: Assets.egyptsplash,
                title: 'Pyramids of Giza and Sphinx',
                description:
                    'One of the Seven Wonders of the ancient world, the famous three Giza Pyramids with the statue of the Great Sphinx',
                location: 'Cairo Governorate',

                onViewMap: () {
                  openLocationLink("https://maps.app.goo.gl/art5k9NAJvDbYiGE9");
                },
              ),
              TourismCard(
                text: 'archaeological',
                imageUrl: Assets.karnak,
                title: 'Karnak Temple (Luxor)',
                description:
                    'A vast temple complex in Luxor, dedicated to Amun, Mut, and Khonsu, featuring towering columns and rich historical magic.',
                location: 'Luxor, Egypt',

                onViewMap: () {
                  openLocationLink("https://maps.app.goo.gl/t388psh3aaWk9hdKA");
                },
              ),
              TourismCard(
                text: 'archaeological',

                imageUrl: Assets.egyptsplash,
                title: 'Pyramids of Giza and Sphinx',
                description:
                    'One of the Seven Wonders of the ancient world, the famous three Giza Pyramids with the statue of the Great Sphinx',
                location: 'Cairo Governorate',

                onViewMap: () {
                  openLocationLink("https://maps.app.goo.gl/art5k9NAJvDbYiGE9");
                },
              ),
              TourismCard(
                text: 'archaeological',

                imageUrl: Assets.karnak,
                title: 'Karnak Temple (Luxor)',
                description:
                    'A vast temple complex in Luxor, dedicated to Amun, Mut, and Khonsu, featuring towering columns and rich historical magic.',
                location: 'Luxor, Egypt',

                onViewMap: () {
                  openLocationLink("https://maps.app.goo.gl/t388psh3aaWk9hdKA");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
