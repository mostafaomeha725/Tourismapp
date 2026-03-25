part of 'package_details_cubit.dart';

class PackageDetailsState extends Equatable {
  final RequestState status;
  final PackageEntity? package;
  final String? errorMessage;

  const PackageDetailsState({
    required this.status,
    required this.package,
    this.errorMessage,
  });

  const PackageDetailsState.initial()
    : status = RequestState.init,
      package = null,
      errorMessage = null;

  PackageDetailsState copyWith({
    RequestState? status,
    PackageEntity? package,
    String? errorMessage,
  }) {
    return PackageDetailsState(
      status: status ?? this.status,
      package: package ?? this.package,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, package, errorMessage];
}
