import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/core/cache/preferences_storage.dart';
import 'package:tourismapp/core/di/services_locator.dart';
import 'package:tourismapp/core/network/network_service.dart';
import 'package:tourismapp/core/services/auth_service.dart';
import 'package:tourismapp/features/auth/domain/entities/register_result_entity.dart';
import 'package:tourismapp/features/auth/domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    final result = await loginUseCase(
      LoginParams(email: email, password: password),
    );

    result.fold((failure) => emit(LoginFailure(failure.message)), (
      success,
    ) async {
      await sl<PreferencesStorage>().saveUserToken(success.token);
      sl<NetworkService>().addToken(success.token);
      AuthService.login();
      emit(LoginSuccess(success));
    });
  }
}
