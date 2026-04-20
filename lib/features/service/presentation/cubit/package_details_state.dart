part of 'package_details_cubit.dart';

enum PackageDetailsActionType { openExternalLink, showError }

class PackageDetailsAction extends Equatable {
  final PackageDetailsActionType type;
  final String? url;
  final String? message;

  const PackageDetailsAction._({required this.type, this.url, this.message});

  const PackageDetailsAction.openExternalLink(String url)
    : this._(type: PackageDetailsActionType.openExternalLink, url: url);

  const PackageDetailsAction.showError(String message)
    : this._(type: PackageDetailsActionType.showError, message: message);

  @override
  List<Object?> get props => [type, url, message];
}

class PackageDetailsState extends Equatable {
  final RequestState status;
  final PackageEntity? package;
  final String? errorMessage;
  final PackageDetailsAction? pendingAction;
  final int actionNonce;

  const PackageDetailsState({
    required this.status,
    required this.package,
    this.errorMessage,
    required this.pendingAction,
    required this.actionNonce,
  });

  const PackageDetailsState.initial()
    : status = RequestState.init,
      package = null,
      errorMessage = null,
      pendingAction = null,
      actionNonce = 0;

  PackageDetailsState copyWith({
    RequestState? status,
    PackageEntity? package,
    String? errorMessage,
    PackageDetailsAction? pendingAction,
    bool clearPendingAction = false,
    int? actionNonce,
  }) {
    return PackageDetailsState(
      status: status ?? this.status,
      package: package ?? this.package,
      errorMessage: errorMessage,
      pendingAction: clearPendingAction
          ? null
          : pendingAction ?? this.pendingAction,
      actionNonce: actionNonce ?? this.actionNonce,
    );
  }

  @override
  List<Object?> get props => [
    status,
    package,
    errorMessage,
    pendingAction,
    actionNonce,
  ];
}
