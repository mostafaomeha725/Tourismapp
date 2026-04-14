class AuthService {
  static bool _isLoggedIn = false;

  static bool get isLoggedIn => _isLoggedIn;

  static void initializeFromToken(String? token) {
    _isLoggedIn = token != null && token.isNotEmpty;
  }

  static void login() {
    _isLoggedIn = true;
  }

  static void logout() {
    _isLoggedIn = false;
  }
}
