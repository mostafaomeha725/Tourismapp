import 'package:tourismapp/features/auth/data/models/client_model.dart';
import 'package:tourismapp/features/auth/domain/entities/update_profile_result_entity.dart';

class UpdateProfileResponseModel extends UpdateProfileResultEntity {
  const UpdateProfileResponseModel({
    required super.message,
    required super.client,
  });

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponseModel(
      message: (json['message'] ?? '').toString(),
      client: ClientModel.fromJson(
        (json['client'] ?? {}) as Map<String, dynamic>,
      ),
    );
  }
}
