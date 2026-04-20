import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final int id;
  final int clientId;
  final int packageId;
  final int rating;
  final String comment;
  final String clientName;
  final DateTime? createdAt;

  const ReviewEntity({
    required this.id,
    required this.clientId,
    required this.packageId,
    required this.rating,
    required this.comment,
    this.clientName = '',
    this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    clientId,
    packageId,
    rating,
    comment,
    clientName,
    createdAt,
  ];
}
