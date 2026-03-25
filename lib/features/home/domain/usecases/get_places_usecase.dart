import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/home/domain/entities/place_entity.dart';
import 'package:tourismapp/features/home/domain/repositories/places_repository.dart';

class GetPlacesUseCase {
  final PlacesRepository placesRepository;

  GetPlacesUseCase(this.placesRepository);

  Future<Either<Failure, List<PlaceEntity>>> call() {
    return placesRepository.getPlaces();
  }
}
