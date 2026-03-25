import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourismapp/core/cache/preferences_storage.dart';
import 'package:tourismapp/core/network/network_service.dart';
import 'package:tourismapp/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tourismapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tourismapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:tourismapp/features/auth/domain/usecases/login_usecase.dart';
import 'package:tourismapp/features/auth/domain/usecases/logout_usecase.dart';
import 'package:tourismapp/features/auth/domain/usecases/register_usecase.dart';
import 'package:tourismapp/features/auth/presentation/cubit/login_cubit.dart';
import 'package:tourismapp/features/auth/presentation/cubit/logout_cubit.dart';
import 'package:tourismapp/features/auth/presentation/cubit/register_cubit.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    await _initStorage();
    _initDio();
    _initAuth();
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

  /// =============================
  /// AUTH
  /// =============================
  void _initAuth() {
    if (!sl.isRegistered<AuthRemoteDataSource>()) {
      sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(sl()),
      );
    }

    if (!sl.isRegistered<AuthRepository>()) {
      sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
    }

    if (!sl.isRegistered<RegisterUseCase>()) {
      sl.registerLazySingleton(() => RegisterUseCase(sl()));
    }

    if (!sl.isRegistered<LoginUseCase>()) {
      sl.registerLazySingleton(() => LoginUseCase(sl()));
    }

    if (!sl.isRegistered<LogoutUseCase>()) {
      sl.registerLazySingleton(() => LogoutUseCase(sl()));
    }

    if (!sl.isRegistered<RegisterCubit>()) {
      sl.registerFactory(() => RegisterCubit(sl()));
    }

    if (!sl.isRegistered<LoginCubit>()) {
      sl.registerFactory(() => LoginCubit(sl()));
    }

    if (!sl.isRegistered<LogoutCubit>()) {
      sl.registerFactory(() => LogoutCubit(sl()));
    }
  }
}
