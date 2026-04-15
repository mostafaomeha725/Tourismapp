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

part 'widgets/tourism_place_screen_query.dart';
part 'widgets/tourism_place_screen_state_content.dart';

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
                  _buildPlacesStateContent(context, state),
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
