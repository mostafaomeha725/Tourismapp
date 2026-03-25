import 'package:equatable/equatable.dart';

class PackageEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final String? link;
  final int categoryId;
  final String categoryName;
  final int providerId;
  final String providerName;
  final int placeId;
  final String placeTitle;
  final String mainImage;
  final List<String> imageUrls;
  final double averageRating;
  final int reviewsCount;

  const PackageEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.link,
    required this.categoryId,
    required this.categoryName,
    required this.providerId,
    required this.providerName,
    required this.placeId,
    required this.placeTitle,
    required this.mainImage,
    required this.imageUrls,
    required this.averageRating,
    required this.reviewsCount,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    price,
    link,
    categoryId,
    categoryName,
    providerId,
    providerName,
    placeId,
    placeTitle,
    mainImage,
    imageUrls,
    averageRating,
    reviewsCount,
  ];
}
