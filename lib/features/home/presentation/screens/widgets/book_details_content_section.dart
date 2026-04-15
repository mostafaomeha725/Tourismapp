import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/features/home/domain/entities/package_entity.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/about_experience_card.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/details_galary_section.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/details_image_header.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/package_reviews_card.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/tour_guide_info_card.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/whats_Included_card.dart';

class BookDetailsContentSection extends StatelessWidget {
  final List<String> images;
  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onFavoriteTap;
  final bool isFavorite;
  final bool isFavoriteLoading;
  final int selectedIndex;
  final ValueChanged<int> onThumbnailTap;
  final PackageEntity package;
  final int packageId;

  const BookDetailsContentSection({
    super.key,
    required this.images,
    required this.pageController,
    required this.onPageChanged,
    required this.onFavoriteTap,
    required this.isFavorite,
    required this.isFavoriteLoading,
    required this.selectedIndex,
    required this.onThumbnailTap,
    required this.package,
    required this.packageId,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 100.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsImageHeader(
            images: images,
            pageController: pageController,
            onPageChanged: onPageChanged,
            onFavoriteTap: onFavoriteTap,
            isFavorite: isFavorite,
            isFavoriteLoading: isFavoriteLoading,
          ),
          SizedBox(height: 16.h),
          DetailsGallerySection(
            images: images,
            selectedIndex: selectedIndex,
            onImageTap: onThumbnailTap,
          ),
          SizedBox(height: 20.h),
          TourGuideInfoCard(package: package),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AboutExperienceCard(description: package.description),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: WhatsIncludedCard(whatsIncluded: package.whatsIncluded),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: PackageReviewsCard(packageId: packageId),
          ),
        ],
      ),
    );
  }
}
