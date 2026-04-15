import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/di/services_locator.dart';
import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/utils/easy_loading.dart';
import 'package:tourismapp/features/auth/presentation/cubit/logout_cubit.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/home_appbar.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/custom_nav_bar_body_stack.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/custom_nav_bar_bottom_bar.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/custom_nav_bar_screens.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/home_drawer.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/show_emergency_sheet.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});
  static _CustomNavBarState? of(BuildContext context) =>
      context.findAncestorStateOfType<_CustomNavBarState>();

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final List<int> _navigationStack = [0];
  final List<Widget> _screens = [];

  late final AnimationController _fabController;
  late final Animation<double> _fabPulse;

  @override
  void initState() {
    super.initState();

    _screens.addAll(buildCustomNavBarScreens(_onItemTapped));

    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _fabPulse = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fabController, curve: Curves.easeInOut));

    _fabController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
      _navigationStack.add(index);
    });
  }

  Future<bool> onWillPop() async {
    if (_navigationStack.length > 1) {
      setState(() {
        _navigationStack.removeLast();
        _selectedIndex = _navigationStack.last;
      });
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LogoutCubit>(),
      child: BlocListener<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutLoading) {
            showLoading(status: 'Signing out...');
          } else if (state is LogoutFailure) {
            showError(state.message);
          } else if (state is LogoutSuccess) {
            showSuccess(state.message);
            GoRouter.of(context).pushReplacement(Routes.loginScreen);
          }
        },
        child: WillPopScope(
          onWillPop: onWillPop,
          child: Scaffold(
            drawer: HomeDrawer(
              onNavigateToTab: (index) => _onItemTapped(index),
            ),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.h),
              child: Builder(
                builder: (context) => HomeAppbar(
                  title: 'Tourism App',
                  onMenuTap: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
            body: CustomNavBarBodyStack(
              selectedIndex: _selectedIndex,
              screens: _screens,
              fabPulse: _fabPulse,
              onEmergencyTap: () => showEmergencySheet(context),
            ),
            bottomNavigationBar: CustomNavBarBottomBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
