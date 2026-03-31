import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/extensions/request_state.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/home/domain/entities/review_entity.dart';
import 'package:tourismapp/features/home/presentation/cubit/package_reviews_cubit.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/details_card_decoration.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/pagination_widget.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/review_item_card.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/review_summary_card.dart';

class PackageReviewsCard extends StatefulWidget {
  final int packageId;

  const PackageReviewsCard({super.key, required this.packageId});

  @override
  State<PackageReviewsCard> createState() => _PackageReviewsCardState();
}

class _PackageReviewsCardState extends State<PackageReviewsCard> {
  @override
  void initState() {
    super.initState();
    context.read<PackageReviewsCubit>().loadReviews(
      packageId: widget.packageId,
    );
  }

  void _onPageChanged(int page) {
    final currentPage = context.read<PackageReviewsCubit>().state.currentPage;
    if (page == currentPage) return;

    context.read<PackageReviewsCubit>().loadReviews(
      packageId: widget.packageId,
      page: page,
    );
  }

  double _calculateAverageRating(List<ReviewEntity> reviews) {
    if (reviews.isEmpty) return 0;
    final total = reviews.fold<int>(0, (sum, review) => sum + review.rating);
    return total / reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackageReviewsCubit, PackageReviewsState>(
      builder: (context, state) {
        if (state.status == RequestState.success && state.reviews.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: detailsCardDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText('Ratings & Reviews', style: font18w700),
              SizedBox(height: 12.h),
              if (state.status == RequestState.loading ||
                  state.status == RequestState.init) ...[
                const Center(child: CircularProgressIndicator()),
              ] else if (state.status == RequestState.error) ...[
                AppText(
                  state.errorMessage ?? 'Failed to load reviews',
                  style: font14w500.copyWith(color: Colors.red),
                  overflow: TextOverflow.visible,
                ),
              ] else ...[
                ReviewSummaryCard(
                  averageRating: _calculateAverageRating(state.reviews),
                  reviewsCount: state.reviews.length,
                ),
                SizedBox(height: 12.h),
                ...List.generate(state.reviews.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == state.reviews.length - 1 ? 0 : 12.h,
                    ),
                    child: ReviewItemCard(review: state.reviews[index]),
                  );
                }),
                if (state.totalPages > 1) ...[
                  SizedBox(height: 10.h),
                  PaginationWidget(
                    totalPages: state.totalPages,
                    currentPage: state.currentPage,
                    onPageChanged: _onPageChanged,
                  ),
                ],
              ],
            ],
          ),
        );
      },
    );
  }
}
