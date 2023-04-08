part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final String appBarTitle;
  final Widget? widget;
  const SettingsState(this.appBarTitle, this.widget);

  const SettingsState.initialState(
      {required this.appBarTitle, required this.widget});

  const SettingsState.email({required this.appBarTitle, required this.widget});

  const SettingsState.password(
      {required this.appBarTitle, required this.widget});

  const SettingsState.subscription(
      {required this.appBarTitle, required this.widget});

  const SettingsState.notifications(
      {required this.appBarTitle, required this.widget});

  const SettingsState.contact(
      {required this.appBarTitle, required this.widget});

  const SettingsState.deleteAccount(this.appBarTitle, this.widget);

  const SettingsState.signOut(this.appBarTitle, this.widget);

  @override
  List<Object?> get props => [appBarTitle, widget];
}
