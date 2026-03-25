import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/auth/domain/entities/register_result_entity.dart';
import 'package:tourismapp/features/auth/domain/usecases/login_usecase.dart';
import 'package:tourismapp/features/auth/domain/usecases/register_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, RegisterResultEntity>> register(RegisterParams params);

  Future<Either<Failure, RegisterResultEntity>> login(LoginParams params);

  Future<Either<Failure, String>> logout();
}
