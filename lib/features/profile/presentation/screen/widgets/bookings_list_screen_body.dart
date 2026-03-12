import 'package:flutter/material.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/booking_list_completed.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/booking_list_confirme.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/booking_list_pending.dart';

class BookingsListScreenBody extends StatefulWidget {
  const BookingsListScreenBody({super.key});

  @override
  State<BookingsListScreenBody> createState() => _BookingsListScreenBodyState();
}

class _BookingsListScreenBodyState extends State<BookingsListScreenBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            labelColor: Color(0xffdb6000),
            labelStyle: font12w700,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xffdb6000),
            tabs: const [
              Tab(text: "pending"),
              Tab(text: "confirmed"),
              Tab(text: "Completed"),
            ],
          ),
        ),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              BookingListPending(),
              BookingListConfirmed(),
              BookingListCompleted(),
            ],
          ),
        ),
      ],
    );
  }
}
