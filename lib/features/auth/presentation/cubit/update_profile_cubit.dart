import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/features/auth/domain/entities/update_profile_result_entity.dart';
import 'package:tourismapp/features/auth/domain/usecases/update_profile_usecase.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileUseCase updateProfileUseCase;

  UpdateProfileCubit(this.updateProfileUseCase) : super(UpdateProfileInitial());

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String email,
    String? password,
    String? passwordConfirmation,
  }) async {
    emit(UpdateProfileLoading());

    final result = await updateProfileUseCase(
      UpdateProfileParams(
        name: name,
        phone: phone,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      ),
    );

    result.fold(
      (failure) => emit(UpdateProfileFailure(failure.message)),
      (success) => emit(UpdateProfileSuccess(success)),
    );
  }
}
