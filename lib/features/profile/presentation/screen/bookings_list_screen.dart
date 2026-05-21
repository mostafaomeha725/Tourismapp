import 'package:flutter/material.dart';

import 'package:tourismapp/features/profile/presentation/screen/widgets/bookings_list_screen_body.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/custom_appbar.dart';
import 'package:tourismapp/l10n/app_localizations.dart';

class BookingsListScreen extends StatelessWidget {
  const BookingsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.allBookings),
      body: const BookingsListScreenBody(),
    );
  }
}
