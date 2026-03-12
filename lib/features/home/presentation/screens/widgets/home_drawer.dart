import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key, this.onNavigateToTab});

  final Function(int)? onNavigateToTab;

  @override
  Widget build(BuildContext context) {
    final drawerWidth = MediaQuery.of(context).size.width / 1.5;

    return Drawer(
      width: drawerWidth,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.orange),
            child: AppText(
              "Menu",
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
                  title: const AppText("Tourist Places"),
                  onTap: () {
                    GoRouter.of(context).pop();
                    onNavigateToTab?.call(0);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.design_services_outlined),
                  title: const AppText("Services"),
                  onTap: () {
                    GoRouter.of(context).pop();
                    onNavigateToTab?.call(1);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.chat_bubble_outline),
                  title: const AppText("helper"),
                  onTap: () {
                    GoRouter.of(context).pop();
                    onNavigateToTab?.call(2);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const AppText("Profile"),
                  onTap: () {
                    GoRouter.of(context).pop();
                    onNavigateToTab?.call(3);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: const AppText("Logout"),
                  onTap: () {
                    GoRouter.of(context).pushReplacement(Routes.loginScreen);
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
