import 'package:tourismapp/features/auth/data/models/client_model.dart';
import 'package:tourismapp/features/auth/domain/entities/register_result_entity.dart';

class RegisterResponseModel extends RegisterResultEntity {
  const RegisterResponseModel({
    required super.message,
    required super.client,
    required super.token,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      message: (json['message'] ?? '').toString(),
      client: ClientModel.fromJson(
        (json['client'] ?? {}) as Map<String, dynamic>,
      ),
      token: (json['token'] ?? '').toString(),
    );
  }
}
