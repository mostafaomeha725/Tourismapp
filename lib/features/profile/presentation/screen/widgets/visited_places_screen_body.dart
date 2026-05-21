import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/extensions/request_state.dart';
import 'package:tourismapp/features/service/domain/entities/packages_page_entity.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/pagination_widget.dart';
import 'package:tourismapp/features/profile/presentation/cubit/favourite_places_cubit.dart';
import 'package:tourismapp/features/profile/presentation/cubit/favourite_places_state.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/visited_places_card.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/l10n/app_localizations.dart';

class VisitedPlacesScreenBody extends StatelessWidget {
  const VisitedPlacesScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocBuilder<FavouritePlacesCubit, FavouritePlacesState>(
      builder: (context, state) {
        if (state.status == RequestState.loading ||
            state.status == RequestState.init) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == RequestState.error) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: AppText(
                state.errorMessage ?? loc.failedToLoadFavorites,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        final PackagesPageEntity? page = state.favoritesPage;
        final favorites = page?.items ?? const [];
        final totalPages = page?.lastPage ?? 1;
        final currentPage = state.currentPage;
        if (favorites.isEmpty) {
          return Center(child: AppText(loc.noFavoritePlacesYet));
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: ListView.separated(
            itemCount: favorites.length + (totalPages > 1 ? 1 : 0),
            separatorBuilder: (context, index) => SizedBox(height: 22.h),
            itemBuilder: (context, index) {
              final isPaginationItem =
                  totalPages > 1 && index == favorites.length;
              if (isPaginationItem) {
                return PaginationWidget(
                  totalPages: totalPages,
                  currentPage: currentPage,
                  onPageChanged: (page) {
                    context.read<FavouritePlacesCubit>().onPageChanged(page);
                  },
                );
              }

              final place = favorites[index];
              return VisitedPlaceCard(
                title: place.title,
                description: place.description.trim().isEmpty
                    ? loc.noDescriptionAvailable
                    : place.description,
                image: place.mainImage,
                rating: place.averageRating,
                price: place.price,
              );
            },
          ),
        );
      },
    );
  }
}
