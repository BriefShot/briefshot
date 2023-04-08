part of 'settings_bloc.dart';

class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class PressOnEmailTile extends SettingsEvent {}

class PressOnBackToSettingButton extends SettingsEvent {}

class PressOnPasswordTile extends SettingsEvent {}

class PressOnNotificationsTile extends SettingsEvent {}

class PressOnSubscriptionTile extends SettingsEvent {}
