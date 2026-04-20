import 'package:equatable/equatable.dart';
import 'package:tourismapp/features/service/domain/entities/review_entity.dart';

class ReviewsPageEntity extends Equatable {
  final List<ReviewEntity> items;
  final int currentPage;
  final int lastPage;

  const ReviewsPageEntity({
    required this.items,
    required this.currentPage,
    required this.lastPage,
  });

  @override
  List<Object?> get props => [items, currentPage, lastPage];
}
