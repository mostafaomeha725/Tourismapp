import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/home/presentation/cubit/places_cubit.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/open_map.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/tourism_card.dart';

class TourismPlaceScreen extends StatelessWidget {
  const TourismPlaceScreen({super.key, this.onNavigateToTab});

  final Function(int)? onNavigateToTab;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesCubit, PlacesState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  AppText('Discover Tourist Places', style: font20w700),
                  SizedBox(height: 4.h),
                  AppText(
                    'Explore the most beautiful destinations in Egypt',
                    overflow: TextOverflow.visible,
                    style: font14w400.copyWith(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16.h),
                  if (state is PlacesLoading || state is PlacesInitial)
                    const Center(child: CircularProgressIndicator())
                  else if (state is PlacesFailure)
                    Column(
                      children: [
                        AppText(
                          state.message,
                          style: font14w400.copyWith(color: Colors.red),
                          alignment: AlignmentDirectional.center,
                        ),
                        SizedBox(height: 10.h),
                        TextButton(
                          onPressed: () =>
                              context.read<PlacesCubit>().loadPlaces(),
                          child: const Text('Retry'),
                        ),
                      ],
                    )
                  else if (state is PlacesEmpty)
                    AppText(
                      'No places available right now',
                      style: font14w400.copyWith(color: Colors.grey[600]),
                      alignment: AlignmentDirectional.center,
                    )
                  else if (state is PlacesSuccess)
                    ...state.places.map((place) {
                      final imageUrl = place.icon.trim().isNotEmpty
                          ? place.icon
                          : Assets.egyptsplash;
                      final description =
                          (place.subTitle ?? '').trim().isNotEmpty
                          ? place.subTitle!.trim()
                          : place.title;
                      final location = (place.location ?? '').trim().isNotEmpty
                          ? place.location!.trim()
                          : 'Unknown location';
                      final hasCoordinates =
                          place.lat != null && place.lng != null;

                      return TourismCard(
                        text: 'وجهة سياحية',
                        imageUrl: imageUrl,
                        title: place.title,
                        description: description,
                        location: location,
                        showMapButton: hasCoordinates,
                        onViewMap: () {
                          if (hasCoordinates) {
                            openLocationLink(
                              'https://www.google.com/maps/search/?api=1&query=${place.lat},${place.lng}',
                            );
                          }
                        },
                      );
                    })
                  else
                    const SizedBox.shrink(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
