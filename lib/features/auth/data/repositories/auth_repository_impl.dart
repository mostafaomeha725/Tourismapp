import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tourismapp/features/auth/domain/entities/register_result_entity.dart';
import 'package:tourismapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:tourismapp/features/auth/domain/usecases/login_usecase.dart';
import 'package:tourismapp/features/auth/domain/usecases/register_usecase.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, RegisterResultEntity>> register(
    RegisterParams params,
  ) async {
    return authRemoteDataSource.register(params);
  }

  @override
  Future<Either<Failure, RegisterResultEntity>> login(
    LoginParams params,
  ) async {
    return authRemoteDataSource.login(params);
  }

  @override
  Future<Either<Failure, String>> logout() async {
    return authRemoteDataSource.logout();
  }
}
