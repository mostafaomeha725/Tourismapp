part of 'book_details_screen_body.dart';

extension _BookDetailsScreenBodyStateContent on _BookDetailsScreenBodyState {
  Widget _buildStateContent(PackageDetailsState state) {
    if (state.status.isLoading || state.status == RequestState.init) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status.isError || state.package == null) {
      final loc = AppLocalizations.of(context)!;
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: AppText(
            state.errorMessage ?? loc.failedToLoadPackageDetails,
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
        BookDetailsContentSection(
          images: images,
          pageController: _pageController,
          onPageChanged: _onPageChanged,
          onFavoriteTap: _toggleFavorite,
          isFavorite: _isFavorite,
          isFavoriteLoading: _isFavoriteLoading,
          selectedIndex: _currentIndex,
          onThumbnailTap: _onThumbnailTapped,
          package: package,
          packageId: widget.packageId,
        ),

        Positioned(
          bottom: 30.h,
          right: 20.w,
          left: 20.w,
          child: AppButton(
            text:
                '${AppLocalizations.of(context)!.bookNow} - \$${package.price.toInt()}',
            onPressed: () async {
              if (!AuthService.isLoggedIn) {
                GoRouter.of(context).push(Routes.authScreen);
                return;
              }

              final url = package.link?.trim();
              if (url == null || url.isEmpty) {
                CustomSnackBar.showError(
                  context,
                  message: AppLocalizations.of(context)!.linkNotAvailable,
                );
                return;
              }

              try {
                await openLocationLink(url);
              } catch (_) {
                if (!context.mounted) {
                  return;
                }
                CustomSnackBar.showError(
                  context,
                  message: AppLocalizations.of(
                    context,
                  )!.couldNotOpenBookingLink,
                );
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
