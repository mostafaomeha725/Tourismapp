import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourismapp/core/di/services_locator.dart';
import 'package:tourismapp/features/home/presentation/cubit/helper_chat_cubit.dart';
import 'package:tourismapp/features/home/presentation/cubit/packages_cubit.dart';
import 'package:tourismapp/features/home/presentation/cubit/places_cubit.dart';
import 'package:tourismapp/features/home/presentation/screens/helper_screen.dart';
import 'package:tourismapp/features/home/presentation/screens/service_screen.dart';
import 'package:tourismapp/features/home/presentation/screens/tourism_place_screen.dart';
import 'package:tourismapp/features/profile/presentation/screen/profile_screen.dart';

List<Widget> buildCustomNavBarScreens(void Function(int) onItemTapped) {
  return [
    BlocProvider(
      create: (_) => sl<PlacesCubit>()..loadPlaces(),
      child: TourismPlaceScreen(
        onNavigateToTab: (index) => onItemTapped(index),
      ),
    ),
    BlocProvider(
      create: (_) => sl<PackagesCubit>()..loadInitialData(),
      child: const ServiceScreen(),
    ),
    BlocProvider(
      create: (_) => sl<HelperChatCubit>(),
      child: const HelperScreen(),
    ),
    const ProfileScreen(),
  ];
}
