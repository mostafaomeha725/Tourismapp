import 'package:tourismapp/features/home/domain/entities/package_entity.dart';

class PackageModel extends PackageEntity {
  const PackageModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.link,
    required super.categoryId,
    required super.categoryName,
    required super.providerId,
    required super.providerName,
    required super.placeId,
    required super.placeTitle,
    required super.mainImage,
    required super.imageUrls,
    required super.whatsIncluded,
    required super.isFavorite,
    required super.averageRating,
    required super.reviewsCount,
  });

  static bool _parseIsFavorite(Map<String, dynamic> json) {
    final raw = json.containsKey('is_favorite')
        ? json['is_favorite']
        : json['isFavorite'];

    if (raw is bool) return raw;
    if (raw is num) return raw != 0;
    if (raw is String) {
      final value = raw.trim().toLowerCase();
      return value == '1' || value == 'true' || value == 'yes';
    }

    return false;
  }

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    final category = (json['category'] as Map<String, dynamic>?) ?? {};
    final provider = (json['provider'] as Map<String, dynamic>?) ?? {};
    final place = (json['place'] as Map<String, dynamic>?) ?? {};
    final mainImage = (json['main_image'] ?? '').toString();
    final imagesRaw = (json['images'] as List?) ?? const [];
    final whatsIncludedRaw = (json['whats_included'] as List?) ?? const [];
    final imageUrls = imagesRaw
        .map((item) {
          if (item is Map<String, dynamic>) {
            return (item['image'] ?? '').toString();
          }
          return '';
        })
        .where((url) => url.isNotEmpty)
        .toList();
    final whatsIncluded = whatsIncludedRaw
        .map((item) {
          if (item == null) return '';
          if (item is Map<String, dynamic>) {
            return (item['title'] ?? item['name'] ?? item['value'] ?? '')
                .toString();
          }
          return item.toString();
        })
        .map((text) => text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    if (imageUrls.isEmpty && mainImage.isNotEmpty) {
      imageUrls.add(mainImage);
    }

    return PackageModel(
      id: json['id'] is int ? json['id'] as int : 0,
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      price: (json['price'] is num)
          ? (json['price'] as num).toDouble()
          : double.tryParse((json['price'] ?? '0').toString()) ?? 0,
      link: json['link']?.toString(),
      categoryId: category['id'] is int ? category['id'] as int : 0,
      categoryName: (category['name'] ?? '').toString(),
      providerId: provider['id'] is int ? provider['id'] as int : 0,
      providerName: (provider['name'] ?? '').toString(),
      placeId: place['id'] is int ? place['id'] as int : 0,
      placeTitle: (place['title'] ?? '').toString(),
      mainImage: mainImage,
      imageUrls: imageUrls,
      whatsIncluded: whatsIncluded,
      isFavorite: _parseIsFavorite(json),
      averageRating: (json['average_rating'] is num)
          ? (json['average_rating'] as num).toDouble()
          : double.tryParse((json['average_rating'] ?? '0').toString()) ?? 0,
      reviewsCount: json['reviews_count'] is int
          ? json['reviews_count'] as int
          : int.tryParse((json['reviews_count'] ?? '0').toString()) ?? 0,
    );
  }
}
