import 'package:tourismapp/features/home/domain/entities/price_range_entity.dart';

class PriceRangeModel extends PriceRangeEntity {
  const PriceRangeModel({required super.minPrice, required super.maxPrice});

  factory PriceRangeModel.fromJson(Map<String, dynamic> json) {
    return PriceRangeModel(
      minPrice: (json['min_price'] is num)
          ? (json['min_price'] as num).toDouble()
          : double.tryParse((json['min_price'] ?? '0').toString()) ?? 0,
      maxPrice: (json['max_price'] is num)
          ? (json['max_price'] as num).toDouble()
          : double.tryParse((json['max_price'] ?? '0').toString()) ?? 0,
    );
  }
}
