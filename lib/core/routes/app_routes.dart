import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:tourismapp/features/auth/presentation/screens/auth_screen.dart';
import 'package:tourismapp/features/auth/presentation/screens/login_screen.dart';
import 'package:tourismapp/features/auth/presentation/screens/register_screen.dart';
import 'package:tourismapp/features/home/presentation/screens/book_details_screen.dart';
import 'package:tourismapp/features/home/presentation/screens/bookings_screen.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/custom_nav_bar.dart';
import 'package:tourismapp/features/onboarding/presentation/screen/onboarding_screen.dart';
import 'package:tourismapp/features/profile/presentation/screen/bookings_list_screen.dart';
import 'package:tourismapp/features/profile/presentation/screen/edit_profile_screen.dart';
import 'package:tourismapp/features/profile/presentation/screen/privacy_policy_screen.dart';
import 'package:tourismapp/features/profile/presentation/screen/terms_of_use_screen.dart';
import 'package:tourismapp/features/profile/presentation/screen/visited_places_screen.dart';
import 'package:tourismapp/features/splash/presentation/screens/splash_screen.dart';
import 'route_paths.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter() {
  return GoRouter(
    initialLocation: Routes.splashScreen,
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    observers: [SentryNavigatorObserver()],
    routes: [
      GoRoute(
        path: Routes.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.onBoardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: Routes.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.registerScreen,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: Routes.authScreen,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: Routes.customNavBar,
        builder: (context, state) => const CustomNavBar(),
      ),
      GoRoute(
        path: Routes.bookingsScreen,
        builder: (context, state) => const BookingsScreen(),
      ),
      GoRoute(
        path: Routes.bookingsListScreen,
        builder: (context, state) => const BookingsListScreen(),
      ),
      GoRoute(
        path: Routes.visitedPlacesScreen,
        builder: (context, state) => const VisitedPlacesScreen(),
      ),
      GoRoute(
        path: Routes.editProfileScreen,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: Routes.bookDetailsScreen,
        builder: (context, state) => const BookDetailsScreen(),
      ),
      GoRoute(
        path: Routes.privacyPolicyScreen,
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: Routes.termsOfUseScreen,
        builder: (context, state) => const TermsOfUseScreen(),
      ),
    ],
  );
}
