import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/core/network/endpoints.dart';
import 'package:tourismapp/core/network/network_service.dart';
import 'package:tourismapp/features/home/data/models/place_model.dart';

abstract class PlacesRemoteDataSource {
  Future<Either<Failure, List<PlaceModel>>> getPlaces();
}

class PlacesRemoteDataSourceImpl implements PlacesRemoteDataSource {
  final NetworkService networkService;

  PlacesRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<Failure, List<PlaceModel>>> getPlaces() async {
    final response = await networkService.getData(endPoint: EndPoints.places);

    return response.fold(Left.new, (data) {
      if (data is Map<String, dynamic>) {
        final list = data['data'];
        if (list is List) {
          return Right(
            list
                .whereType<Map<String, dynamic>>()
                .map(PlaceModel.fromJson)
                .toList(),
          );
        }
      }
      return const Left(Failure('Unexpected response format'));
    });
  }
}
