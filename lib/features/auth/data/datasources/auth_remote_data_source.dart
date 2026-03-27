import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/core/network/endpoints.dart';
import 'package:tourismapp/core/network/network_service.dart';
import 'package:tourismapp/features/auth/data/models/register_response_model.dart';
import 'package:tourismapp/features/auth/domain/usecases/login_usecase.dart';
import 'package:tourismapp/features/auth/domain/usecases/register_usecase.dart';
import 'package:tourismapp/features/auth/data/models/update_profile_response_model.dart';
import 'package:tourismapp/features/auth/domain/usecases/update_profile_usecase.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, RegisterResponseModel>> register(
    RegisterParams params,
  );

  Future<Either<Failure, RegisterResponseModel>> login(LoginParams params);

  Future<Either<Failure, String>> logout();

  Future<Either<Failure, UpdateProfileResponseModel>> updateProfile(
    UpdateProfileParams params,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetworkService networkService;

  AuthRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<Failure, RegisterResponseModel>> register(
    RegisterParams params,
  ) async {
    final response = await networkService.postData(
      endPoint: EndPoints.register,
      data: {
        'name': params.name,
        'phone': params.phone,
        'email': params.email,
        'password': params.password,
        'password_confirmation': params.passwordConfirmation,
      },
    );

    return response.fold(Left.new, (data) {
      if (data is Map<String, dynamic>) {
        return Right(RegisterResponseModel.fromJson(data));
      }
      return const Left(Failure('Unexpected response format'));
    });
  }

  @override
  Future<Either<Failure, RegisterResponseModel>> login(
    LoginParams params,
  ) async {
    final response = await networkService.postData(
      endPoint: EndPoints.login,
      data: {'email': params.email, 'password': params.password},
    );

    return response.fold(Left.new, (data) {
      if (data is Map<String, dynamic>) {
        return Right(RegisterResponseModel.fromJson(data));
      }
      return const Left(Failure('Unexpected response format'));
    });
  }

  @override
  Future<Either<Failure, String>> logout() async {
    final response = await networkService.postData(endPoint: EndPoints.logout);

    return response.fold(Left.new, (data) {
      if (data is Map<String, dynamic>) {
        final message = (data['message'] ?? 'Logged out successfully.')
            .toString();
        return Right(message);
      }
      return const Right('Logged out successfully.');
    });
  }

  @override
  Future<Either<Failure, UpdateProfileResponseModel>> updateProfile(
    UpdateProfileParams params,
  ) async {
    final payload = <String, dynamic>{
      'name': params.name,
      'phone': params.phone,
      'email': params.email,
      if (params.password != null && params.password!.isNotEmpty)
        'password': params.password,
      if (params.passwordConfirmation != null &&
          params.passwordConfirmation!.isNotEmpty)
        'password_confirmation': params.passwordConfirmation,
    };

    final response = await networkService.postData(
      endPoint: EndPoints.updateProfile,
      data: payload,
    );

    return response.fold(Left.new, (data) {
      if (data is Map<String, dynamic>) {
        return Right(UpdateProfileResponseModel.fromJson(data));
      }
      return const Left(Failure('Unexpected response format'));
    });
  }
}
