import 'package:tourismapp/features/service/data/models/review_model.dart';
import 'package:tourismapp/features/service/domain/entities/reviews_page_entity.dart';

class ReviewsPageModel extends ReviewsPageEntity {
  const ReviewsPageModel({
    required super.items,
    required super.currentPage,
    required super.lastPage,
  });

  factory ReviewsPageModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    final items = data is List
        ? data
              .whereType<Map<String, dynamic>>()
              .map(ReviewModel.fromJson)
              .toList()
        : <ReviewModel>[];

    return ReviewsPageModel(
      items: items,
      currentPage: json['current_page'] is int
          ? json['current_page'] as int
          : int.tryParse((json['current_page'] ?? '1').toString()) ?? 1,
      lastPage: json['last_page'] is int
          ? json['last_page'] as int
          : int.tryParse((json['last_page'] ?? '1').toString()) ?? 1,
    );
  }
}
