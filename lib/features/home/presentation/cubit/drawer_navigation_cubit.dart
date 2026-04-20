import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'drawer_navigation_state.dart';

class DrawerNavigationCubit extends Cubit<DrawerNavigationState> {
  static const int touristPlacesTabIndex = 0;
  static const int servicesTabIndex = 1;
  static const int helperTabIndex = 2;
  static const int profileTabIndex = 3;

  DrawerNavigationCubit() : super(const DrawerNavigationState.initial());

  void onTouristPlacesTapped() {
    _emitAction(
      const DrawerNavigationAction.switchToTab(touristPlacesTabIndex),
    );
  }

  void onServicesTapped() {
    _emitAction(const DrawerNavigationAction.switchToTab(servicesTabIndex));
  }

  void onHelperTapped() {
    _emitAction(const DrawerNavigationAction.switchToTab(helperTabIndex));
  }

  // Business rule: Profile tab is available for both guest and logged-in users.
  void onProfileTapped() {
    _emitAction(const DrawerNavigationAction.switchToTab(profileTabIndex));
  }

  void onLogoutTapped({required bool isLoggedIn}) {
    if (!isLoggedIn) {
      _emitAction(const DrawerNavigationAction.openAuth());
      return;
    }

    _emitAction(const DrawerNavigationAction.logout());
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

  void _emitAction(DrawerNavigationAction action) {
    emit(
      state.copyWith(pendingAction: action, actionNonce: state.actionNonce + 1),
    );
  }
}
