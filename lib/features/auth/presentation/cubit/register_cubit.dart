import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/core/cache/preferences_storage.dart';
import 'package:tourismapp/core/di/services_locator.dart';
import 'package:tourismapp/core/enums/app_enums.dart';
import 'package:tourismapp/core/network/network_service.dart';
import 'package:tourismapp/core/services/auth_service.dart';
import 'package:tourismapp/features/auth/domain/entities/register_result_entity.dart';
import 'package:tourismapp/features/auth/domain/usecases/register_usecase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

  Future<void> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(RegisterLoading());

    final result = await registerUseCase(
      RegisterParams(
        name: name,
        phone: phone,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      ),
    );

    result.fold((failure) => emit(RegisterFailure(failure.message)), (
      success,
    ) async {
      final prefs = sl<PreferencesStorage>();
      await prefs.saveUserToken(success.token);
      await prefs.putString(
        key: PreferencesKeys.name,
        value: success.client.name,
      );
      await prefs.putString(
        key: PreferencesKeys.email,
        value: success.client.email,
      );
      await prefs.putString(
        key: PreferencesKeys.phone,
        value: success.client.phone,
      );
      sl<NetworkService>().addToken(success.token);
      AuthService.login();
      emit(RegisterSuccess(success));
    });
  }
}
