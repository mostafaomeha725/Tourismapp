import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourismapp/core/di/services_locator.dart';
import 'package:tourismapp/features/profile/presentation/cubit/favourite_places_cubit.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/custom_appbar.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/visited_places_screen_body.dart';

class FavouritePlacesScreen extends StatelessWidget {
  const FavouritePlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Favourite places'),
      body: BlocProvider(
        create: (_) => sl<FavouritePlacesCubit>()..loadFavorites(page: 1),
        child: const VisitedPlacesScreenBody(),
      ),
    );
  }
}
