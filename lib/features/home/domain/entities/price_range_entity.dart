import 'package:equatable/equatable.dart';

class PriceRangeEntity extends Equatable {
  final double minPrice;
  final double maxPrice;

  const PriceRangeEntity({required this.minPrice, required this.maxPrice});

  @override
  List<Object?> get props => [minPrice, maxPrice];
}
