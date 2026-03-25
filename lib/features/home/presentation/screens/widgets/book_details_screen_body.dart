import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/core/extensions/request_state.dart';
import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/services/auth_service.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

import 'package:tourismapp/features/home/domain/entities/package_entity.dart';
import 'package:tourismapp/features/home/presentation/cubit/package_details_cubit.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/about_experience_card.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/details_galary_section.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/details_image_header.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/tour_guide_info_card.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/whats_Included_card.dart';

class BookDetailsScreenBody extends StatefulWidget {
  final int packageId;

  const BookDetailsScreenBody({super.key, required this.packageId});

  @override
  State<BookDetailsScreenBody> createState() => _BookDetailsScreenBodyState();
}

class _BookDetailsScreenBodyState extends State<BookDetailsScreenBody> {
  static const List<String> _fallbackImages = [
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
      final package = context.read<PackageDetailsCubit>().state.package;
      final images = _resolveImages(package);
      if (images.isEmpty) {
        throw Exception('No image available');
      }

      final String imagePath = images[_currentIndex];
      if (imagePath.startsWith('http')) {
        // ignore: deprecated_member_use
        await Share.share(imagePath);
        return;
      }

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

  List<String> _resolveImages(PackageEntity? package) {
    if (package == null) return _fallbackImages;
    if (package.imageUrls.isNotEmpty) return package.imageUrls;
    if (package.mainImage.isNotEmpty) return [package.mainImage];
    return _fallbackImages;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackageDetailsCubit, PackageDetailsState>(
      builder: (context, state) {
        if (state.status.isLoading || state.status == RequestState.init) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status.isError || state.package == null) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: AppText(
                state.errorMessage ?? 'Failed to load package details',
                style: font14w500.copyWith(color: Colors.red),
                alignment: AlignmentDirectional.center,
                overflow: TextOverflow.visible,
              ),
            ),
          );
        }

        final package = state.package!;
        final images = _resolveImages(package);

        if (_currentIndex >= images.length) {
          _currentIndex = 0;
        }

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
                  TourGuideInfoCard(package: package),

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
                text: 'book now - \$${package.price.toInt()}',
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
      },
    );
  }
}
