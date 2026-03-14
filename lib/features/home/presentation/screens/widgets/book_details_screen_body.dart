import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/services/auth_service.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';

import 'package:tourismapp/features/home/presentation/screens/widgets/about_experience_card.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/details_galary_section.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/details_image_header.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/tour_guide_info_card.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/whats_Included_card.dart';

class BookDetailsScreenBody extends StatefulWidget {
  const BookDetailsScreenBody({super.key});

  @override
  State<BookDetailsScreenBody> createState() => _BookDetailsScreenBodyState();
}

class _BookDetailsScreenBodyState extends State<BookDetailsScreenBody> {
  final List<String> images = [
    Assets.egyptsplash,
    Assets.karnak,
    Assets.logo,
    Assets.egyptsplash,
    Assets.karnak,
    Assets.logo,
    Assets.egyptsplash,
    Assets.karnak,
  ];

  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onThumbnailTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> _shareSelectedImage() async {
    try {
      final String imagePath = images[_currentIndex];
      final ByteData byteData = await rootBundle.load(imagePath);
      final Uint8List list = byteData.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/shared_image.png');
      await file.writeAsBytes(list);

      // ignore: deprecated_member_use
      await Share.shareXFiles([XFile(file.path)]);
    } catch (e) {
      debugPrint('Error sharing image: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to share image')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 100.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailsImageHeader(
                images: images,
                pageController: _pageController,
                onPageChanged: _onPageChanged,
                onShareTap: _shareSelectedImage,
              ),

              SizedBox(height: 16.h),

              DetailsGallerySection(
                images: images,
                selectedIndex: _currentIndex,
                onImageTap: _onThumbnailTapped,
              ),

              SizedBox(height: 20.h),
              TourGuideInfoCard(),

              SizedBox(height: 20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: AboutExperienceCard(),
              ),

              SizedBox(height: 20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: WhatsIncludedCard(),
              ),
            ],
          ),
        ),

        Positioned(
          bottom: 30.h,
          right: 20.w,
          left: 20.w,
          child: AppButton(
            text: 'book now - \$50',
            onPressed: () {
              if (AuthService.isLoggedIn) {
                GoRouter.of(context).push(Routes.bookingsScreen);
              } else {
                GoRouter.of(context).push(Routes.authScreen);
              }
            },
            color: Color(0xffdb6000),
            height: 50.h,
          ),
        ),
      ],
    );
  }
}
