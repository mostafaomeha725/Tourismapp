import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/di/services_locator.dart';
import 'package:tourismapp/core/utils/easy_loading.dart';
import 'package:tourismapp/features/home/presentation/cubit/submit_review_cubit.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/rate_service_dialog_actions.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/rate_service_dialog_comment_section.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/rate_service_dialog_header.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/rate_service_dialog_rating_section.dart';

class RateServiceDialog extends StatefulWidget {
  final int packageId;
  final String title;

  const RateServiceDialog({
    super.key,
    required this.packageId,
    required this.title,
  });

  @override
  State<RateServiceDialog> createState() => _RateServiceDialogState();
}

class _RateServiceDialogState extends State<RateServiceDialog> {
  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitReview(BuildContext context) async {
    if (_rating <= 0) {
      showError('Please choose a rating first');
      return;
    }

    await context.read<SubmitReviewCubit>().submitReview(
      packageId: widget.packageId,
      rating: _rating,
      comment: _commentController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SubmitReviewCubit>(),
      child: BlocListener<SubmitReviewCubit, SubmitReviewState>(
        listener: (context, state) {
          if (state is SubmitReviewLoading) {
            showLoading(status: 'Submitting review...');
          } else if (state is SubmitReviewSuccess) {
            showSuccess(state.result.message);
            Navigator.of(context).pop(true);
          } else if (state is SubmitReviewFailure) {
            showError(state.message);
          }
        },
        child: Builder(
          builder: (dialogContext) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(20.w),
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.r,
                      offset: Offset(0, 10.h),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RateServiceDialogHeader(
                        title: widget.title,
                        onClose: () => Navigator.of(dialogContext).pop(),
                      ),

                      SizedBox(height: 25.h),

                      RateServiceDialogRatingSection(
                        rating: _rating,
                        onRatingChanged: (value) {
                          setState(() {
                            _rating = value;
                          });
                        },
                      ),

                      SizedBox(height: 20.h),

                      RateServiceDialogCommentSection(
                        controller: _commentController,
                      ),

                      SizedBox(height: 25.h),

                      RateServiceDialogActions(
                        onSubmit: () => _submitReview(dialogContext),
                        onCancel: () {
                          Navigator.of(dialogContext).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
