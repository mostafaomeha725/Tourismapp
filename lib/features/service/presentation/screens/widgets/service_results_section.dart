import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/extensions/request_state.dart';
import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/services/auth_service.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/service/domain/entities/package_entity.dart';
import 'package:tourismapp/core/utils/open_map.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/pagination_widget.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/tourism_card.dart';

class ServiceResultsSection extends StatelessWidget {
  final RequestState status;
  final String? errorMessage;
  final List<PackageEntity> packages;
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;
  final Future<void> Function() onReviewSubmitted;

  const ServiceResultsSection({
    super.key,
    required this.status,
    required this.errorMessage,
    required this.packages,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    required this.onReviewSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    bool ensureAuthenticated() {
      if (AuthService.isLoggedIn) {
        return true;
      }

      GoRouter.of(context).push(Routes.authScreen);
      return false;
    }

    if (status.isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 60.h),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (status.isError) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 60.h),
        child: AppText(
          errorMessage ?? 'Something went wrong',
          style: font14w500.copyWith(color: Colors.red),
          alignment: AlignmentDirectional.center,
        ),
      );
    }

    if (packages.isEmpty) {
      return Padding(
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
      );
    }

    return Column(
      children: [
        ...packages.map((item) {
          return TourismCard(
            text: item.categoryName,
            imageUrl: item.mainImage,
            title: item.title,
            description: item.description,
            location: item.placeTitle,
            isicon: true,
            icon: Icons.star_rounded,
            price: item.price,
            rating: item.averageRating,
            reviewsCount: item.reviewsCount,
            packageId: item.id,
            onReviewSubmitted: onReviewSubmitted,
            onViewMap: () {
              if (!ensureAuthenticated()) {
                return;
              }

              final url = item.link;
              if (url != null && url.isNotEmpty) {
                openLocationLink(url);
              }
            },
            onCardTap: () {
              if (!ensureAuthenticated()) {
                return;
              }

              GoRouter.of(context).push(Routes.bookDetailsById(item.id));
            },
            onBook: () async {
              if (!ensureAuthenticated()) {
                return;
              }

              final url = item.link?.trim();
              if (url == null || url.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Link is not available for this package yet.',
                    ),
                  ),
                );
                return;
              }

              try {
                await openLocationLink(url);
              } catch (_) {
                if (!context.mounted) {
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Could not open the booking link.'),
                  ),
                );
              }
            },
          );
        }),
        if (status.isSuccess && totalPages > 1)
          PaginationWidget(
            totalPages: totalPages,
            currentPage: currentPage,
            onPageChanged: onPageChanged,
          ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
