import 'package:equatable/equatable.dart';
import 'package:tourismapp/features/auth/domain/entities/client_entity.dart';

class RegisterResultEntity extends Equatable {
  final String message;
  final ClientEntity client;
  final String token;

  const RegisterResultEntity({
    required this.message,
    required this.client,
    required this.token,
  });

  @override
  List<Object?> get props => [message, client, token];
}
