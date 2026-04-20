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
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

import 'package:tourismapp/features/service/domain/entities/package_entity.dart';
import 'package:tourismapp/features/service/domain/usecases/toggle_favorite_usecase.dart';
import 'package:tourismapp/features/service/presentation/cubit/package_details_cubit.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/book_details_content_section.dart';
import 'package:tourismapp/core/utils/open_map.dart';

part 'book_details_screen_body_interactions.dart';
part 'book_details_screen_body_state_content.dart';

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

  void _withStateUpdate(VoidCallback updater) {
    setState(updater);
  }

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackageDetailsCubit, PackageDetailsState>(
      builder: (context, state) => _buildStateContent(state),
    );
  }
}
