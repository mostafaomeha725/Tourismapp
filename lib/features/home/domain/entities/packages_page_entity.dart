import 'package:equatable/equatable.dart';
import 'package:tourismapp/features/home/domain/entities/package_entity.dart';

class PackagesPageEntity extends Equatable {
  final List<PackageEntity> items;
  final int currentPage;
  final int lastPage;

  const PackagesPageEntity({
    required this.items,
    required this.currentPage,
    required this.lastPage,
  });

  @override
  List<Object?> get props => [items, currentPage, lastPage];
}
