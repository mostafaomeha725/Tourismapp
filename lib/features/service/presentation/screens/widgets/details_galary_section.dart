import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/widgets/app_image.dart';

class DetailsGallerySection extends StatelessWidget {
  final List<String> images;
  final int selectedIndex;
  final ValueChanged<int> onImageTap;

  const DetailsGallerySection({
    super.key,
    required this.images,
    required this.selectedIndex,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: List.generate(images.length, (index) {
            bool isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () => onImageTap(index),
              child: Container(
                margin: EdgeInsets.only(right: 12.w),
                width: 70.w,
                height: 70.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: isSelected
                      ? Border.all(color: const Color(0xFFE87306), width: 2.w)
                      : null,
                ),
                clipBehavior: Clip.antiAlias,
                child: ColorFiltered(
                  colorFilter: isSelected
                      ? const ColorFilter.mode(
                          Colors.transparent,
                          BlendMode.multiply,
                        )
                      : const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.saturation,
                        ),
                  child: images[index].startsWith('http')
                      ? AppImage(
                          imageUrl: images[index],
                          width: 70.w,
                          height: 70.h,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          images[index],
                          width: 70.w,
                          height: 70.h,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
