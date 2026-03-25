import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/core/extensions/request_state.dart';
import 'package:tourismapp/features/home/domain/entities/package_entity.dart';
import 'package:tourismapp/features/home/domain/usecases/get_package_by_id_usecase.dart';

part 'package_details_state.dart';

class PackageDetailsCubit extends Cubit<PackageDetailsState> {
  final GetPackageByIdUseCase getPackageByIdUseCase;

  PackageDetailsCubit(this.getPackageByIdUseCase)
    : super(const PackageDetailsState.initial());

  Future<void> loadPackageDetails(int packageId) async {
    emit(state.copyWith(status: RequestState.loading, errorMessage: null));

    final result = await getPackageByIdUseCase(packageId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestState.error,
          errorMessage: failure.message,
        ),
      ),
      (package) => emit(
        state.copyWith(
          status: RequestState.success,
          package: package,
          errorMessage: null,
        ),
      ),
    );
  }
}
