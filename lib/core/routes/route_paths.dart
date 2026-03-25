class Routes {
  static const splashScreen = '/splash';
  static const onBoardingScreen = '/onboarding';

  static const loginScreen = '/Login';
  static const registerScreen = '/Register';
  static const authScreen = '/Auth';
  static const customNavBar = '/customNavBar';
  static const bookingsScreen = '/bookingsScreen';
  static const bookingsListScreen = '/bookingsListScreen';
  static const visitedPlacesScreen = '/visitedPlacesScreen';
  static const editProfileScreen = '/editProfileScreen';
  static const bookDetailsScreen = '/bookDetailsScreen';
  static String bookDetailsById(int id) => '$bookDetailsScreen/$id';
  static const privacyPolicyScreen = '/privacypolicyScreen';
  static const termsOfUseScreen = '/TermsOfUseScreen';
}
