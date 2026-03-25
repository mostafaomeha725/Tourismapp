import 'package:tourismapp/features/home/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.clientId,
    required super.packageId,
    required super.rating,
    required super.comment,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] is int ? json['id'] as int : 0,
      clientId: json['client_id'] is int ? json['client_id'] as int : 0,
      packageId: json['package_id'] is int ? json['package_id'] as int : 0,
      rating: json['rating'] is int
          ? json['rating'] as int
          : int.tryParse((json['rating'] ?? '0').toString()) ?? 0,
      comment: (json['comment'] ?? '').toString(),
    );
  }
}
