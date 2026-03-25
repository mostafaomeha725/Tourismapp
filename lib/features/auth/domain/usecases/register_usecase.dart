import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/auth/domain/entities/register_result_entity.dart';
import 'package:tourismapp/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase(this.authRepository);

  Future<Either<Failure, RegisterResultEntity>> call(RegisterParams params) {
    return authRepository.register(params);
  }
}

class RegisterParams extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String passwordConfirmation;

  const RegisterParams({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
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
