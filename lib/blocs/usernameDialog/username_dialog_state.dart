part of 'username_dialog_bloc.dart';

abstract class UsernameDialogState extends Equatable {
  String? username;
  UsernameDialogState({this.username});

  @override
  List<Object?> get props => [username];
}

class UsernameDialogInitial extends UsernameDialogState {
  UsernameDialogInitial() : super(username: null);

  @override
  List<Object> get props => [];
}

class UsernameDialogAppear extends UsernameDialogState {
  late String? username;
  UsernameDialogAppear() : super(username: null);

  @override
  List<Object> get props => [];
}

class UsernameDialogFieldUptadedValue extends UsernameDialogState {
  final String username;

  UsernameDialogFieldUptadedValue(this.username) : super(username: username);

  @override
  List<Object> get props => [username];
}

class UsernameDialogSubmitted extends UsernameDialogState {
  final String username;

  UsernameDialogSubmitted(this.username) : super(username: username);

  @override
  List<Object> get props => [username];
}

class UsernameDialogValueOk extends UsernameDialogState {
  final String username;
  UsernameDialogValueOk(this.username) : super(username: username);

  @override
  List<Object> get props => [username];
}

class UsernameDialogError extends UsernameDialogState {
  final uuid = const Uuid().v4();
  UsernameDialogError() : super(username: null);

  @override
  List<Object> get props => [uuid];
}
