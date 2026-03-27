import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/auth/domain/entities/update_profile_result_entity.dart';
import 'package:tourismapp/features/auth/domain/repositories/auth_repository.dart';

class UpdateProfileUseCase {
  final AuthRepository authRepository;

  UpdateProfileUseCase(this.authRepository);

  Future<Either<Failure, UpdateProfileResultEntity>> call(
    UpdateProfileParams params,
  ) {
    return authRepository.updateProfile(params);
  }
}

class UpdateProfileParams extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String? password;
  final String? passwordConfirmation;

  const UpdateProfileParams({
    required this.name,
    required this.phone,
    required this.email,
    this.password,
    this.passwordConfirmation,
  });

  @override
  List<Object?> get props => [
    name,
    phone,
    email,
    password,
    passwordConfirmation,
  ];
}
