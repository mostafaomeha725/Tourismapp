import 'package:tourismapp/features/home/data/models/package_model.dart';
import 'package:tourismapp/features/home/domain/entities/packages_page_entity.dart';

class PackagesPageModel extends PackagesPageEntity {
  const PackagesPageModel({
    required super.items,
    required super.currentPage,
    required super.lastPage,
  });

  factory PackagesPageModel.fromJson(Map<String, dynamic> json) {
    final meta = (json['meta'] as Map<String, dynamic>?) ?? {};
    final data = json['data'];

    final items = data is List
        ? data
              .whereType<Map<String, dynamic>>()
              .map(PackageModel.fromJson)
              .toList()
        : <PackageModel>[];

    return PackagesPageModel(
      items: items,
      currentPage: meta['current_page'] is int
          ? meta['current_page'] as int
          : int.tryParse((meta['current_page'] ?? '1').toString()) ?? 1,
      lastPage: meta['last_page'] is int
          ? meta['last_page'] as int
          : int.tryParse((meta['last_page'] ?? '1').toString()) ?? 1,
    );
  }
}
