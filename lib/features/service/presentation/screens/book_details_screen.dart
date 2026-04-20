import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourismapp/core/di/services_locator.dart';
import 'package:tourismapp/features/service/presentation/cubit/package_details_cubit.dart';
import 'package:tourismapp/features/service/presentation/cubit/package_reviews_cubit.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/book_details_screen_body.dart';

class BookDetailsScreen extends StatelessWidget {
  final int packageId;

  const BookDetailsScreen({super.key, required this.packageId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              sl<PackageDetailsCubit>()..loadPackageDetails(packageId),
        ),
        BlocProvider(create: (_) => sl<PackageReviewsCubit>()),
      ],
      child: Scaffold(body: BookDetailsScreenBody(packageId: packageId)),
    );
  }
}
