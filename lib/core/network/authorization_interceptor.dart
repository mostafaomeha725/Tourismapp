import 'package:dio/dio.dart';
import 'package:tourismapp/core/cache/preferences_storage.dart';
import 'package:tourismapp/core/di/services_locator.dart';

class AuthorizationInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = sl<PreferencesStorage>();

    final token = prefs.getUserToken();
    final lang = prefs.getCurrentLanguage();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = "Bearer $token";
    }

    options.headers['Accept-Language'] = lang;

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      print("Unauthenticated → redirect to login");
    }
    handler.next(err);
  }
}
