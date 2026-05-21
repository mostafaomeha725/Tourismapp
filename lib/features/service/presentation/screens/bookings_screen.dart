import 'package:flutter/material.dart';

import 'package:tourismapp/features/service/presentation/screens/widgets/bookings_screen_body.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/custom_appbar.dart';
import 'package:tourismapp/l10n/app_localizations.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: CustomAppBar(title: AppLocalizations.of(context)!.bookService),
      body: BookingsScreenBody(),
    );
  }
}
