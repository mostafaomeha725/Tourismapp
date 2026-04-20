import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/service/domain/entities/favorite_toggle_result_entity.dart';
import 'package:tourismapp/features/service/domain/repositories/packages_repository.dart';

class ToggleFavoriteUseCase {
  final PackagesRepository packagesRepository;

  ToggleFavoriteUseCase(this.packagesRepository);

  Future<Either<Failure, FavoriteToggleResultEntity>> call(
    ToggleFavoriteParams params,
  ) {
    return packagesRepository.toggleFavorite(params.packageId);
  }
}

class ToggleFavoriteParams extends Equatable {
  final int packageId;

  const ToggleFavoriteParams({required this.packageId});

  @override
  List<Object?> get props => [packageId];
}
