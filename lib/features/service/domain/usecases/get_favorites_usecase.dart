import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/service/domain/entities/packages_page_entity.dart';
import 'package:tourismapp/features/service/domain/repositories/packages_repository.dart';

class GetFavoritesUseCase {
  final PackagesRepository packagesRepository;

  GetFavoritesUseCase(this.packagesRepository);

  Future<Either<Failure, PackagesPageEntity>> call(GetFavoritesParams params) {
    return packagesRepository.getFavorites(page: params.page);
  }
}

class GetFavoritesParams extends Equatable {
  final int? page;

  const GetFavoritesParams({this.page});

  @override
  List<Object?> get props => [page];
}
