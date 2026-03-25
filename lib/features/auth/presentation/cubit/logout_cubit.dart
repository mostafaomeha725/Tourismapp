import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/core/cache/preferences_storage.dart';
import 'package:tourismapp/core/di/services_locator.dart';
import 'package:tourismapp/core/network/network_service.dart';
import 'package:tourismapp/core/services/auth_service.dart';
import 'package:tourismapp/features/auth/domain/usecases/logout_usecase.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutUseCase logoutUseCase;

  LogoutCubit(this.logoutUseCase) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());

    final result = await logoutUseCase();

    result.fold((failure) => emit(LogoutFailure(failure.message)), (
      message,
    ) async {
      await sl<PreferencesStorage>().deleteUserToken();
      sl<NetworkService>().removeToken();
      AuthService.logout();
      emit(LogoutSuccess(message));
    });
  }
}
