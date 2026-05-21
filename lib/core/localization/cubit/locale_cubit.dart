import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourismapp/core/cache/preferences_storage.dart';
import 'package:tourismapp/core/enums/app_enums.dart';

import 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final PreferencesStorage _preferencesStorage;

  LocaleCubit(this._preferencesStorage)
    : super(const LocaleInitial(Locale('en'))) {
    _loadSavedLocale();
  }

  void _loadSavedLocale() {
    final languageCode = _preferencesStorage.getCurrentLanguage();
    emit(LocaleInitial(Locale(languageCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    await _preferencesStorage.putString(
      key: PreferencesKeys.currentLanguage,
      value: languageCode,
    );
    emit(LocaleChanged(Locale(languageCode)));
  }
}
