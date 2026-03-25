import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/home/domain/entities/place_entity.dart';

abstract class PlacesRepository {
  Future<Either<Failure, List<PlaceEntity>>> getPlaces();
}
