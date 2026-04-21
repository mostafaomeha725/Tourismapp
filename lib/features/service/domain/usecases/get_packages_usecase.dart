import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/service/domain/entities/packages_page_entity.dart';
import 'package:tourismapp/features/service/domain/repositories/packages_repository.dart';

enum PackagesSortOption {
  newest('newest'),
  priceAsc('price_asc'),
  priceDesc('price_desc'),
  alphabetical('alphabetical');

  final String apiValue;

  const PackagesSortOption(this.apiValue);
}

class GetPackagesUseCase {
  final PackagesRepository packagesRepository;

  GetPackagesUseCase(this.packagesRepository);

  Future<Either<Failure, PackagesPageEntity>> call(GetPackagesParams params) {
    return packagesRepository.getPackages(params);
  }
}

class GetPackagesParams extends Equatable {
  final String? search;
  final int? categoryId;
  final int? providerId;
  final int? placeId;
  final double? minPrice;
  final double? maxPrice;
  final PackagesSortOption? sort;
  final int? page;

  const GetPackagesParams({
    this.search,
    this.categoryId,
    this.providerId,
    this.placeId,
    this.minPrice,
    this.maxPrice,
    this.sort,
    this.page,
  });

  Map<String, dynamic> toQueryParameters() {
    return {
      if (search != null && search!.isNotEmpty) 'search': search,
      if (categoryId != null) 'category_id': categoryId,
      if (providerId != null) 'provider_id': providerId,
      if (placeId != null) 'place_id': placeId,
      if (minPrice != null) 'min_price': minPrice!.toInt(),
      if (maxPrice != null) 'max_price': maxPrice!.toInt(),
      if (sort != null) 'sort': sort!.apiValue,
      if (page != null) 'page': page,
    };
  }

  @override
  List<Object?> get props => [
    search,
    categoryId,
    providerId,
    placeId,
    minPrice,
    maxPrice,
    sort,
    page,
  ];
}
