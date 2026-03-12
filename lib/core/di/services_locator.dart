import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourismapp/core/cache/preferences_storage.dart';
import 'package:tourismapp/core/network/network_service.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    await _initStorage();
    _initDio();
  }

  /// =============================
  /// STORAGE
  /// =============================
  Future<void> _initStorage() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => PreferencesStorage(sl()));
  }

  /// =============================
  /// NETWORK
  /// =============================
  void _initDio() {
    sl.registerLazySingleton(() => Dio());
    sl.registerLazySingleton(() => NetworkService(sl()));
  }

  //   if (!sl.isRegistered<LoginUseCase>()) {
  //   sl.registerLazySingleton(() => LoginUseCase(sl()));
  // }
  // if (!sl.isRegistered<LoginWithGoogleUseCase>()) {
  //   sl.registerLazySingleton(() => LoginWithGoogleUseCase(sl()));
  // }
  // if (!sl.isRegistered<RegisterUseCase>()) {
  //   sl.registerLazySingleton(() => RegisterUseCase(sl()));
  // }
}
