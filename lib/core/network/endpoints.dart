class EndPoints {
  /// Auth endpoints
  static const String register = 'register';
  static const String login = 'login';
  static const String logout = 'logout';
  static const String sendOtp = 'auth/send-otp';
  static const String verifyOtp = 'auth/verify-otp';
  static const String forgotPassword = 'auth/forgot-password';
  static const String resetPassword = 'auth/reset-password';

  /// Profile endpoints
  static const String profile = 'profile';
  static const String updateProfile = 'profile/update';

  /// Services / Trips endpoints
  static const String services = 'services';
  static String serviceDetails(int id) => 'services/$id';
  static const String packages = 'packages';
  static String packageDetails(int id) => 'packages/$id';
  static String packageReviews(int id) => 'packages/$id/reviews';
  static const String packagesPriceRange = 'packages-price-range';
  static const String places = 'places';
  static const String categories = 'categories';
  static const String reviews = 'reviews';
  static const String favorites = 'favorites';
  static const String favoritesToggle = 'favorites/toggle';
  static const String chatbot = 'chatbot';

  /// Bookings endpoints
  static const String bookings = 'bookings';
  static String bookingDetails(int id) => 'bookings/$id';
  static const String createBooking = 'bookings/create';
  static String cancelBooking(int id) => 'bookings/$id/cancel';
  static String rateService(int id) => 'services/$id/rate';
}
