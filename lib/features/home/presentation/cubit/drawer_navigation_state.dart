part of 'drawer_navigation_cubit.dart';

enum DrawerNavigationActionType { switchToTab, openAuth, logout }

class DrawerNavigationAction extends Equatable {
  final DrawerNavigationActionType type;
  final int? tabIndex;

  const DrawerNavigationAction._({required this.type, this.tabIndex});

  const DrawerNavigationAction.switchToTab(int tabIndex)
    : this._(type: DrawerNavigationActionType.switchToTab, tabIndex: tabIndex);

  const DrawerNavigationAction.openAuth()
    : this._(type: DrawerNavigationActionType.openAuth);

  const DrawerNavigationAction.logout()
    : this._(type: DrawerNavigationActionType.logout);

  @override
  List<Object?> get props => [type, tabIndex];
}

class DrawerNavigationState extends Equatable {
  final DrawerNavigationAction? pendingAction;
  final int actionNonce;

  const DrawerNavigationState({
    required this.pendingAction,
    required this.actionNonce,
  });

  const DrawerNavigationState.initial() : pendingAction = null, actionNonce = 0;

  DrawerNavigationState copyWith({
    DrawerNavigationAction? pendingAction,
    bool clearPendingAction = false,
    int? actionNonce,
  }) {
    return DrawerNavigationState(
      pendingAction: clearPendingAction
          ? null
          : pendingAction ?? this.pendingAction,
      actionNonce: actionNonce ?? this.actionNonce,
    );
  }

  @override
  List<Object?> get props => [pendingAction, actionNonce];
}
