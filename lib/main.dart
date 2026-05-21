import 'package:flutter/material.dart';
import 'package:tourismapp/core/cache/preferences_storage.dart';
import 'package:tourismapp/core/di/services_locator.dart';
import 'package:tourismapp/core/services/auth_service.dart';
import 'package:tourismapp/core/utils/easy_loading.dart';
import 'package:tourismapp/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator().init();

  final token = sl<PreferencesStorage>().getUserToken();
  AuthService.initializeFromToken(token);

  configureEasyLoading();
  runApp(const MyApp());
}
