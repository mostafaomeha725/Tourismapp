import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/home/presentation/cubit/places_cubit.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/open_map.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/tourism_card.dart';

class TourismPlaceScreen extends StatelessWidget {
  const TourismPlaceScreen({super.key, this.onNavigateToTab});

  final Function(int)? onNavigateToTab;

  Future<bool> _isPlaceQueryResolvable(String query) async {
    if (query.trim().isEmpty) {
      return false;
    }

    final uri = Uri.https('nominatim.openstreetmap.org', '/search', {
      'q': query,
      'format': 'jsonv2',
      'limit': '1',
    });

    try {
      final response = await http.get(
        uri,
        headers: {'User-Agent': 'tourismapp/1.0'},
      );

      if (response.statusCode != 200) {
        return false;
      }

      final decoded = jsonDecode(response.body);
      return decoded is List && decoded.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

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
                      final title = place.title.trim();
                      final placeLocation = (place.location ?? '').trim();
                      final imageUrl = place.icon.trim().isNotEmpty
                          ? place.icon
                          : Assets.egyptsplash;
                      final description =
                          (place.subTitle ?? '').trim().isNotEmpty
                          ? place.subTitle!.trim()
                          : place.title;
                      final location = placeLocation.isNotEmpty
                          ? placeLocation
                          : 'Unknown location';
                      final hasCoordinates =
                          place.lat != null && place.lng != null;
                      final placeQueryParts = <String>[
                        if (title.isNotEmpty) title,
                        if (placeLocation.isNotEmpty) placeLocation,
                      ];
                      final placeQuery = placeQueryParts.join(', ');
                      final searchQuery = placeQuery.isNotEmpty
                          ? '$placeQuery, Egypt'
                          : '';

                      final placeSearchUrl = searchQuery.isNotEmpty
                          ? 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(searchQuery)}'
                          : null;
                      final coordinatesUrl = hasCoordinates
                          ? 'https://www.google.com/maps?q=${place.lat},${place.lng}'
                          : null;

                      final canOpenMap =
                          placeSearchUrl != null || coordinatesUrl != null;

                      return TourismCard(
                        text: 'Wander Places',
                        imageUrl: imageUrl,
                        title: place.title,
                        description: description,
                        location: location,
                        showMapButton: canOpenMap,
                        onViewMap: () async {
                          if (placeSearchUrl != null &&
                              coordinatesUrl != null) {
                            final isNameValid = await _isPlaceQueryResolvable(
                              searchQuery,
                            );
                            openLocationLink(
                              isNameValid ? placeSearchUrl : coordinatesUrl,
                            );
                            return;
                          }

                          if (placeSearchUrl != null) {
                            openLocationLink(placeSearchUrl);
                            return;
                          }

                          if (coordinatesUrl != null) {
                            openLocationLink(coordinatesUrl);
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
