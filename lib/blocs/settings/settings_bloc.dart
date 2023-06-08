import 'package:bloc/bloc.dart';
import 'package:briefshot/main.dart';
import 'package:briefshot/repository/UserRepository.dart';
import 'package:briefshot/screens/AuthentificationScreen.dart';
import 'package:briefshot/widgets/UpdateEmailForm.dart';
import 'package:briefshot/widgets/UpdatePasswordForm.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc()
      : super(const SettingsState.initialState(
            appBarTitle: 'Paramètres', widget: null)) {
    on<PressOnEmailTile>((event, emit) {
      emit(
          SettingsState.email(appBarTitle: 'Email', widget: UpdateEmailForm()));
    });
    on<PressOnPasswordTile>((event, emit) {
      emit(SettingsState.password(
          appBarTitle: 'Mot de passe', widget: UpdatePasswordForm()));
    });
    on<PressOnNotificationsTile>((event, emit) {
      emit(const SettingsState.notifications(
          appBarTitle: 'Notifications', widget: null));
    });
    on<PressOnSubscriptionTile>((event, emit) {
      emit(const SettingsState.subscription(
          appBarTitle: 'Abonnement', widget: null));
    });

    on<PressOnLogoutTile>((event, emit) async {
      await UserRepository().signOut();
    });

    on<PressOnBackToSettingButton>((event, emit) {
      emit(const SettingsState.initialState(
          appBarTitle: 'Paramètres', widget: null));
    });
  }
}
