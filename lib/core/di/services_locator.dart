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
import 'package:tourismapp/features/auth/domain/usecases/update_profile_usecase.dart';
import 'package:tourismapp/features/auth/presentation/cubit/login_cubit.dart';
import 'package:tourismapp/features/auth/presentation/cubit/logout_cubit.dart';
import 'package:tourismapp/features/auth/presentation/cubit/register_cubit.dart';
import 'package:tourismapp/features/auth/presentation/cubit/update_profile_cubit.dart';
import 'package:tourismapp/features/home/data/datasources/packages_remote_data_source.dart';
import 'package:tourismapp/features/home/data/datasources/places_remote_data_source.dart';
import 'package:tourismapp/features/home/data/datasources/categories_remote_data_source.dart';
import 'package:tourismapp/features/home/data/datasources/helper_chat_remote_data_source.dart';
import 'package:tourismapp/features/home/data/repositories/categories_repository_impl.dart';
import 'package:tourismapp/features/home/data/repositories/helper_chat_repository_impl.dart';
import 'package:tourismapp/features/home/data/repositories/packages_repository_impl.dart';
import 'package:tourismapp/features/home/data/repositories/places_repository_impl.dart';
import 'package:tourismapp/features/home/domain/repositories/categories_repository.dart';
import 'package:tourismapp/features/home/domain/repositories/helper_chat_repository.dart';
import 'package:tourismapp/features/home/domain/repositories/packages_repository.dart';
import 'package:tourismapp/features/home/domain/repositories/places_repository.dart';
import 'package:tourismapp/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:tourismapp/features/home/domain/usecases/get_favorites_usecase.dart';
import 'package:tourismapp/features/home/domain/usecases/get_package_by_id_usecase.dart';
import 'package:tourismapp/features/home/domain/usecases/get_packages_price_range_usecase.dart';
import 'package:tourismapp/features/home/domain/usecases/get_packages_usecase.dart';
import 'package:tourismapp/features/home/domain/usecases/get_package_reviews_usecase.dart';
import 'package:tourismapp/features/home/domain/usecases/get_places_usecase.dart';
import 'package:tourismapp/features/home/domain/usecases/send_helper_chat_message_usecase.dart';
import 'package:tourismapp/features/home/domain/usecases/submit_review_usecase.dart';
import 'package:tourismapp/features/home/domain/usecases/toggle_favorite_usecase.dart';
import 'package:tourismapp/features/home/presentation/cubit/helper_chat_cubit.dart';
import 'package:tourismapp/features/home/presentation/cubit/package_details_cubit.dart';
import 'package:tourismapp/features/home/presentation/cubit/package_reviews_cubit.dart';
import 'package:tourismapp/features/home/presentation/cubit/places_cubit.dart';
import 'package:tourismapp/features/home/presentation/cubit/packages_cubit.dart';
import 'package:tourismapp/features/home/presentation/cubit/submit_review_cubit.dart';
import 'package:tourismapp/features/profile/presentation/cubit/favourite_places_cubit.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    await _initStorage();
    _initDio();
    _initAuth();
    _initHome();
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

    if (!sl.isRegistered<UpdateProfileUseCase>()) {
      sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
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

    if (!sl.isRegistered<UpdateProfileCubit>()) {
      sl.registerFactory(() => UpdateProfileCubit(sl()));
    }
  }

  /// =============================
  /// HOME
  /// =============================
  void _initHome() {
    if (!sl.isRegistered<PackagesRemoteDataSource>()) {
      sl.registerLazySingleton<PackagesRemoteDataSource>(
        () => PackagesRemoteDataSourceImpl(sl()),
      );
    }

    if (!sl.isRegistered<PlacesRemoteDataSource>()) {
      sl.registerLazySingleton<PlacesRemoteDataSource>(
        () => PlacesRemoteDataSourceImpl(sl()),
      );
    }

    if (!sl.isRegistered<CategoriesRemoteDataSource>()) {
      sl.registerLazySingleton<CategoriesRemoteDataSource>(
        () => CategoriesRemoteDataSourceImpl(sl()),
      );
    }

    if (!sl.isRegistered<HelperChatRemoteDataSource>()) {
      sl.registerLazySingleton<HelperChatRemoteDataSource>(
        () => HelperChatRemoteDataSourceImpl(),
      );
    }

    if (!sl.isRegistered<PackagesRepository>()) {
      sl.registerLazySingleton<PackagesRepository>(
        () => PackagesRepositoryImpl(sl()),
      );
    }

    if (!sl.isRegistered<PlacesRepository>()) {
      sl.registerLazySingleton<PlacesRepository>(
        () => PlacesRepositoryImpl(sl()),
      );
    }

    if (!sl.isRegistered<CategoriesRepository>()) {
      sl.registerLazySingleton<CategoriesRepository>(
        () => CategoriesRepositoryImpl(sl()),
      );
    }

    if (!sl.isRegistered<HelperChatRepository>()) {
      sl.registerLazySingleton<HelperChatRepository>(
        () => HelperChatRepositoryImpl(sl()),
      );
    }

    if (!sl.isRegistered<GetPackagesUseCase>()) {
      sl.registerLazySingleton(() => GetPackagesUseCase(sl()));
    }

    if (!sl.isRegistered<GetPackagesPriceRangeUseCase>()) {
      sl.registerLazySingleton(() => GetPackagesPriceRangeUseCase(sl()));
    }

    if (!sl.isRegistered<GetPackageByIdUseCase>()) {
      sl.registerLazySingleton(() => GetPackageByIdUseCase(sl()));
    }

    if (!sl.isRegistered<GetPackageReviewsUseCase>()) {
      sl.registerLazySingleton(() => GetPackageReviewsUseCase(sl()));
    }

    if (!sl.isRegistered<GetFavoritesUseCase>()) {
      sl.registerLazySingleton(() => GetFavoritesUseCase(sl()));
    }

    if (!sl.isRegistered<ToggleFavoriteUseCase>()) {
      sl.registerLazySingleton(() => ToggleFavoriteUseCase(sl()));
    }

    if (!sl.isRegistered<GetPlacesUseCase>()) {
      sl.registerLazySingleton(() => GetPlacesUseCase(sl()));
    }

    if (!sl.isRegistered<SubmitReviewUseCase>()) {
      sl.registerLazySingleton(() => SubmitReviewUseCase(sl()));
    }

    if (!sl.isRegistered<GetCategoriesUseCase>()) {
      sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
    }

    if (!sl.isRegistered<SendHelperChatMessageUseCase>()) {
      sl.registerLazySingleton(() => SendHelperChatMessageUseCase(sl()));
    }

    if (!sl.isRegistered<PackagesCubit>()) {
      sl.registerFactory(() => PackagesCubit(sl(), sl(), sl(), sl()));
    }

    if (!sl.isRegistered<PlacesCubit>()) {
      sl.registerFactory(() => PlacesCubit(sl()));
    }

    if (!sl.isRegistered<PackageDetailsCubit>()) {
      sl.registerFactory(() => PackageDetailsCubit(sl()));
    }

    if (!sl.isRegistered<PackageReviewsCubit>()) {
      sl.registerFactory(() => PackageReviewsCubit(sl()));
    }

    if (!sl.isRegistered<SubmitReviewCubit>()) {
      sl.registerFactory(() => SubmitReviewCubit(sl()));
    }

    if (!sl.isRegistered<FavouritePlacesCubit>()) {
      sl.registerFactory(() => FavouritePlacesCubit(sl()));
    }

    if (!sl.isRegistered<HelperChatCubit>()) {
      sl.registerFactory(() => HelperChatCubit(sl()));
    }
  }
}
