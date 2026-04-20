import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/services/auth_service.dart';
import 'package:tourismapp/features/service/presentation/screens/rate_service_dialog.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/tourism_card_body.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/tourism_card_header.dart';

class TourismCard extends StatelessWidget {
  static const String _noImagePlaceholderUrl =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/640px-No_image_available.svg.png';

  final String imageUrl;
  final String title;
  final String description;
  final String location;
  final VoidCallback onViewMap;
  final String text;
  final IconData? icon;
  final bool isicon;
  final void Function()? onCardTap;
  final void Function()? onBook;
  final double? price;
  final double? rating;
  final int? reviewsCount;
  final int? packageId;
  final Future<void> Function()? onReviewSubmitted;
  final bool showMapButton;

  const TourismCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.location,
    required this.onViewMap,
    required this.text,
    this.icon,
    this.isicon = false,
    this.onCardTap,
    this.onBook,
    this.price,
    this.rating,
    this.reviewsCount,
    this.packageId,
    this.onReviewSubmitted,
    this.showMapButton = true,
  });

  Future<void> _onEvaluatePressed(BuildContext context) async {
    if (!AuthService.isLoggedIn) {
      GoRouter.of(context).push(Routes.authScreen);
      return;
    }

    if (packageId == null) {
      return;
    }

    final didSubmit = await showDialog<bool>(
      context: context,
      builder: (context) =>
          RateServiceDialog(packageId: packageId!, title: title),
    );

    if (didSubmit == true) {
      await onReviewSubmitted?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final normalizedImageUrl = imageUrl.trim();
    final lowerImageValue = normalizedImageUrl.toLowerCase();
    final normalizedLocation = location.trim();
    final lowerLocationValue = normalizedLocation.toLowerCase();
    final hasValidImage =
        normalizedImageUrl.isNotEmpty &&
        lowerImageValue != 'null' &&
        lowerImageValue != 'undefined' &&
        lowerImageValue != 'n/a';
    final hasLocation =
        normalizedLocation.isNotEmpty &&
        lowerLocationValue != 'null' &&
        lowerLocationValue != 'undefined' &&
        lowerLocationValue != 'n/a' &&
        lowerLocationValue != 'unknown location';
    final isNetworkImage =
        normalizedImageUrl.startsWith('http://') ||
        normalizedImageUrl.startsWith('https://');

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: GestureDetector(
        onTap: onCardTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TourismCardHeader(
                normalizedImageUrl: normalizedImageUrl,
                placeholderImageUrl: _noImagePlaceholderUrl,
                hasValidImage: hasValidImage,
                isNetworkImage: isNetworkImage,
                text: text,
                isicon: isicon,
                icon: icon,
                hasLocation: hasLocation,
                normalizedLocation: normalizedLocation,
              ),
              TourismCardBody(
                title: title,
                description: description,
                isicon: isicon,
                hasLocation: hasLocation,
                normalizedLocation: normalizedLocation,
                showMapButton: showMapButton,
                onViewMap: onViewMap,
                onEvaluate: () => _onEvaluatePressed(context),
                onBook: onBook,
                price: price,
                rating: rating,
                reviewsCount: reviewsCount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
