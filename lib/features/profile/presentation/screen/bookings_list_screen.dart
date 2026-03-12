import 'package:flutter/material.dart';

import 'package:tourismapp/features/profile/presentation/screen/widgets/bookings_list_screen_body.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/custom_appbar.dart';

class BookingsListScreen extends StatelessWidget {
  const BookingsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'All Bookings'),
      body: BookingsListScreenBody(),
    );
  }
}
