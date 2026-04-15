part of '../tourism_place_screen.dart';

extension _TourismPlaceScreenStateContent on TourismPlaceScreen {
  Widget _buildPlacesStateContent(BuildContext context, PlacesState state) {
    if (state is PlacesLoading || state is PlacesInitial) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is PlacesFailure) {
      return Column(
        children: [
          AppText(
            state.message,
            style: font14w400.copyWith(color: Colors.red),
            alignment: AlignmentDirectional.center,
          ),
          SizedBox(height: 10.h),
          TextButton(
            onPressed: () => context.read<PlacesCubit>().loadPlaces(),
            child: const Text('Retry'),
          ),
        ],
      );
    }

    if (state is PlacesEmpty) {
      return AppText(
        'No places available right now',
        style: font14w400.copyWith(color: Colors.grey[600]),
        alignment: AlignmentDirectional.center,
      );
    }

    if (state is PlacesSuccess) {
      return Column(
        children: state.places.map((place) {
          final title = place.title.trim();
          final placeLocation = (place.location ?? '').trim();
          final imageUrl = place.icon.trim().isNotEmpty
              ? place.icon
              : Assets.egyptsplash;
          final description = (place.subTitle ?? '').trim().isNotEmpty
              ? place.subTitle!.trim()
              : place.title;
          final location = placeLocation.isNotEmpty
              ? placeLocation
              : 'Unknown location';
          final hasCoordinates = place.lat != null && place.lng != null;
          final placeQueryParts = <String>[
            if (title.isNotEmpty) title,
            if (placeLocation.isNotEmpty) placeLocation,
          ];
          final placeQuery = placeQueryParts.join(', ');
          final searchQuery = placeQuery.isNotEmpty ? '$placeQuery, Egypt' : '';

          final placeSearchUrl = searchQuery.isNotEmpty
              ? 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(searchQuery)}'
              : null;
          final coordinatesUrl = hasCoordinates
              ? 'https://www.google.com/maps?q=${place.lat},${place.lng}'
              : null;

          final canOpenMap = placeSearchUrl != null || coordinatesUrl != null;

          return TourismCard(
            text: 'Wander Places',
            imageUrl: imageUrl,
            title: place.title,
            description: description,
            location: location,
            showMapButton: canOpenMap,
            onViewMap: () async {
              if (placeSearchUrl != null && coordinatesUrl != null) {
                final isNameValid = await _isPlaceQueryResolvable(searchQuery);
                openLocationLink(isNameValid ? placeSearchUrl : coordinatesUrl);
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
        }).toList(),
      );
    }

    return const SizedBox.shrink();
  }
}
