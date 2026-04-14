import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/core/di/services_locator.dart';
import 'package:tourismapp/core/extensions/request_state.dart';
import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/services/auth_service.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

import 'package:tourismapp/features/home/domain/entities/package_entity.dart';
import 'package:tourismapp/features/home/domain/usecases/toggle_favorite_usecase.dart';
import 'package:tourismapp/features/home/presentation/cubit/package_details_cubit.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/about_experience_card.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/details_galary_section.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/details_image_header.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/package_reviews_card.dart';
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
  bool _isFavorite = false;
  int? _favoriteSyncedPackageId;
  bool _isFavoriteLoading = false;

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

  @override
  void didUpdateWidget(covariant BookDetailsScreenBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.packageId != widget.packageId) {
      _currentIndex = 0;
      _favoriteSyncedPackageId = null;
      _isFavorite = false;
      _isFavoriteLoading = false;
      _pageController.jumpToPage(0);
    }
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

  Future<void> _toggleFavorite() async {
    if (!AuthService.isLoggedIn) {
      if (!mounted) return;
      GoRouter.of(context).push(Routes.authScreen);
      return;
    }

    if (_isFavoriteLoading) return;

    setState(() => _isFavoriteLoading = true);

    final result = await sl<ToggleFavoriteUseCase>().call(
      ToggleFavoriteParams(packageId: widget.packageId),
    );

    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() => _isFavoriteLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(failure.message)));
      },
      (response) {
        setState(() {
          _isFavoriteLoading = false;
          _favoriteSyncedPackageId = widget.packageId;
          _isFavorite = response.isFavorite;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(response.message)));
      },
    );
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
        if (_favoriteSyncedPackageId != package.id) {
          _isFavorite = package.isFavorite;
          _favoriteSyncedPackageId = package.id;
        }

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
                    onFavoriteTap: _toggleFavorite,
                    isFavorite: _isFavorite,
                    isFavoriteLoading: _isFavoriteLoading,
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
                    child: AboutExperienceCard(
                      description: package.description,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: WhatsIncludedCard(
                      whatsIncluded: package.whatsIncluded,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: PackageReviewsCard(packageId: widget.packageId),
                  ),
                ],
              ),
            ),

            // Positioned(
            //   bottom: 30.h,
            //   right: 20.w,
            //   left: 20.w,
            //   child: AppButton(
            //     text: 'book now - \$${package.price.toInt()}',
            //     onPressed: () {
            //       if (AuthService.isLoggedIn) {
            //         GoRouter.of(context).push(Routes.bookingsScreen);
            //       } else {
            //         GoRouter.of(context).push(Routes.authScreen);
            //       }
            //     },
            //     color: Color(0xffdb6000),
            //     height: 50.h,
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
