import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/services/auth_service.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/auth/presentation/cubit/logout_cubit.dart';
import 'package:tourismapp/l10n/app_localizations.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key, this.onNavigateToTab});

  final Function(int)? onNavigateToTab;

  @override
  Widget build(BuildContext context) {
    final drawerWidth = MediaQuery.of(context).size.width / 1.5;
    final loc = AppLocalizations.of(context)!;

    return Drawer(
      width: drawerWidth,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.orange),
            child: AppText(
              loc.drawerMenu,
              style: font24w400,
              alignment: AlignmentDirectional.bottomStart,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(Icons.place_outlined),
                  title: AppText(loc.touristPlaces),
                  onTap: () {
                    GoRouter.of(context).pop();
                    onNavigateToTab?.call(0);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.design_services_outlined),
                  title: AppText(loc.services),
                  onTap: () {
                    GoRouter.of(context).pop();
                    onNavigateToTab?.call(1);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.chat_bubble_outline),
                  title: AppText(loc.helper),
                  onTap: () {
                    GoRouter.of(context).pop();
                    onNavigateToTab?.call(2);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: AppText(loc.profile),
                  onTap: () {
                    GoRouter.of(context).pop();
                    onNavigateToTab?.call(3);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: AppText(loc.logout),
                  onTap: () {
                    if (!AuthService.isLoggedIn) {
                      GoRouter.of(context).pop();
                      GoRouter.of(context).push(Routes.authScreen);
                      return;
                    }
                    GoRouter.of(context).pop();
                    context.read<LogoutCubit>().logout();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
