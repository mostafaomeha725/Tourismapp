import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/di/services_locator.dart';
import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/utils/easy_loading.dart';
import 'package:tourismapp/features/auth/presentation/cubit/logout_cubit.dart';
import 'package:tourismapp/features/home/presentation/screens/helper_screen.dart';
import 'package:tourismapp/features/home/presentation/cubit/packages_cubit.dart';

import 'package:tourismapp/features/home/presentation/screens/home_screen.dart';
import 'package:tourismapp/features/home/presentation/screens/service_screen.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/home_appbar.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/home_drawer.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/nav_bar_item.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/show_emergency_sheet.dart';
import 'package:tourismapp/features/profile/presentation/screen/profile_screen.dart';

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

    _screens.addAll([
      HomeScreen(onNavigateToTab: (index) => _onItemTapped(index)),
      BlocProvider(
        create: (_) => sl<PackagesCubit>()..loadInitialData(),
        child: const ServiceScreen(),
      ),
      const HelperScreen(),
      const ProfileScreen(),
    ]);

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
    bool isProfileScreen = _selectedIndex == 3;

    // ignore: deprecated_member_use
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
            body: Stack(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _screens[_selectedIndex],
                ),

                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  bottom: isProfileScreen ? -100.h : 40.h,
                  left: 22.w,
                  child: GestureDetector(
                    onTap: () => showEmergencySheet(context),
                    child: AnimatedBuilder(
                      animation: _fabPulse,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fabPulse.value,
                          child: Container(
                            padding: EdgeInsets.all(16.h),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8.r,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.error_outline,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.white,
              height: 80.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavBarItem(
                    icon: Icons.place_outlined,
                    isSelected: _selectedIndex == 0,
                    onTap: () => _onItemTapped(0),
                    label: 'Tourist places',
                  ),
                  NavBarItem(
                    icon: Icons.design_services_outlined,
                    isSelected: _selectedIndex == 1,
                    onTap: () => _onItemTapped(1),
                    label: 'Services',
                  ),
                  NavBarItem(
                    icon: Icons.chat_bubble_outline,
                    isSelected: _selectedIndex == 2,
                    onTap: () => _onItemTapped(2),
                    label: 'Helper',
                  ),
                  NavBarItem(
                    icon: Icons.person_outline,
                    isSelected: _selectedIndex == 3,
                    onTap: () => _onItemTapped(3),
                    label: 'profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
