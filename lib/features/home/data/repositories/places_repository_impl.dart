import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/home/data/datasources/places_remote_data_source.dart';
import 'package:tourismapp/features/home/domain/entities/place_entity.dart';
import 'package:tourismapp/features/home/domain/repositories/places_repository.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  final PlacesRemoteDataSource placesRemoteDataSource;

  PlacesRepositoryImpl(this.placesRemoteDataSource);

  @override
  Future<Either<Failure, List<PlaceEntity>>> getPlaces() async {
    return placesRemoteDataSource.getPlaces();
  }
}
