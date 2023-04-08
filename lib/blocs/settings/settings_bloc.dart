import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc()
      : super(const SettingsState.initialState(
            appBarTitle: 'Paramètres', widget: null)) {
    on<PressOnEmailTile>((event, emit) {
      emit(const SettingsState.email(appBarTitle: 'Email', widget: null));
    });
    on<PressOnPasswordTile>((event, emit) {
      emit(const SettingsState.password(
          appBarTitle: 'Mot de passe', widget: null));
    });
    on<PressOnNotificationsTile>((event, emit) {
      emit(const SettingsState.notifications(
          appBarTitle: 'Notifications', widget: null));
    });
    on<PressOnBackToSettingButton>((event, emit) {
      emit(const SettingsState.initialState(
          appBarTitle: 'Paramètres', widget: null));
    });
  }
}
