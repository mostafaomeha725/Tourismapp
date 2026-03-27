import 'package:equatable/equatable.dart';
import 'package:tourismapp/features/auth/domain/entities/client_entity.dart';

class UpdateProfileResultEntity extends Equatable {
  final String message;
  final ClientEntity client;

  const UpdateProfileResultEntity({
    required this.message,
    required this.client,
  });

  @override
  List<Object?> get props => [message, client];
}
