part of 'book_details_screen_body.dart';

extension _BookDetailsScreenBodyInteractions on _BookDetailsScreenBodyState {
  void _onThumbnailTapped(int index) {
    _withStateUpdate(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    _withStateUpdate(() {
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

    _withStateUpdate(() => _isFavoriteLoading = true);

    final result = await sl<ToggleFavoriteUseCase>().call(
      ToggleFavoriteParams(packageId: widget.packageId),
    );

    if (!mounted) return;

    result.fold(
      (failure) {
        _withStateUpdate(() => _isFavoriteLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(failure.message)));
      },
      (response) {
        _withStateUpdate(() {
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
    if (package == null) return _BookDetailsScreenBodyState._fallbackImages;
    if (package.imageUrls.isNotEmpty) return package.imageUrls;
    if (package.mainImage.isNotEmpty) return [package.mainImage];
    return _BookDetailsScreenBodyState._fallbackImages;
  }
}
