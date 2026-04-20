import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/core/extensions/request_state.dart';
import 'package:tourismapp/features/service/domain/entities/package_entity.dart';
import 'package:tourismapp/features/service/domain/usecases/get_package_by_id_usecase.dart';
import 'package:tourismapp/features/service/domain/usecases/resolve_package_booking_link_usecase.dart';

part 'package_details_state.dart';

class PackageDetailsCubit extends Cubit<PackageDetailsState> {
  final GetPackageByIdUseCase getPackageByIdUseCase;
  final ResolvePackageBookingLinkUseCase resolvePackageBookingLinkUseCase;

  PackageDetailsCubit(
    this.getPackageByIdUseCase,
    this.resolvePackageBookingLinkUseCase,
  ) : super(const PackageDetailsState.initial());

  void onLocationTapped() {
    final package = state.package;
    if (package == null) {
      _emitAction(
        const PackageDetailsAction.showError('Package data is not loaded yet.'),
      );
      return;
    }

    _resolveAndEmitExternalLink(
      rawLink: package.locationLink,
      unavailableMessage: 'Package location link is not available yet.',
      invalidMessage: 'Package location link is invalid.',
    );
  }

  void clearPendingAction() {
    if (state.pendingAction == null) {
      return;
    }

    emit(
      state.copyWith(
        clearPendingAction: true,
        actionNonce: state.actionNonce + 1,
      ),
    );
  }

  Future<void> _resolveAndEmitExternalLink({
    required String? rawLink,
    required String unavailableMessage,
    required String invalidMessage,
  }) async {
    final result = await resolvePackageBookingLinkUseCase(rawLink);

    result.fold(
      (failure) {
        final message =
            failure.message ==
                ResolvePackageBookingLinkUseCase.invalidLinkMessage
            ? invalidMessage
            : unavailableMessage;
        _emitAction(PackageDetailsAction.showError(message));
      },
      (link) {
        _emitAction(PackageDetailsAction.openExternalLink(link));
      },
    );
  }

  void _emitAction(PackageDetailsAction action) {
    emit(
      state.copyWith(pendingAction: action, actionNonce: state.actionNonce + 1),
    );
  }

  Future<void> loadPackageDetails(int packageId) async {
    emit(state.copyWith(status: RequestState.loading, errorMessage: null));

    final result = await getPackageByIdUseCase(packageId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestState.error,
          errorMessage: failure.message,
          clearPendingAction: true,
        ),
      ),
      (package) => emit(
        state.copyWith(
          status: RequestState.success,
          package: package,
          errorMessage: null,
          clearPendingAction: true,
        ),
      ),
    );
  }
}
