import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/widgets/app_asset.dart';

class DetailsImageHeader extends StatelessWidget {
  final List<String> images;
  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onShareTap;

  const DetailsImageHeader({
    super.key,
    required this.images,
    required this.pageController,
    required this.onPageChanged,
    required this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320.h,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.r),
              ),
              child: PageView.builder(
                controller: pageController,
                onPageChanged: onPageChanged,
                itemCount: images.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return AppAsset(assetName: images[index], fit: BoxFit.cover);
                },
              ),
            ),
          ),
          Positioned(
            top: 30.h,
            right: 20.w,
            child: _buildCircleIcon(Icons.share, onShareTap),
          ),
          Positioned(
            top: 30.h,
            left: 20.w,
            child: _buildCircleIcon(Icons.arrow_back_ios_new, () {
              GoRouter.of(context).pop();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.r,
              spreadRadius: 1.r,
            ),
          ],
        ),
        child: Icon(icon, size: 22.sp, color: Colors.black87),
      ),
    );
  }
}
