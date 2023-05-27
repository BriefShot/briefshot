part of 'username_dialog_bloc.dart';

abstract class UsernameDialogEvent extends Equatable {
  const UsernameDialogEvent();

  @override
  List<Object> get props => [];
}

class UsernameDialogAsked extends UsernameDialogEvent {
  const UsernameDialogAsked();
}

class UsernameDialogFieldChanged extends UsernameDialogEvent {
  final String username;

  const UsernameDialogFieldChanged(this.username);

  @override
  List<Object> get props => [username];
}

class UsernameDialogFieldSubmitted extends UsernameDialogEvent {
  final String? username;
  const UsernameDialogFieldSubmitted(this.username);

  @override
  List<Object> get props => [];
}

class UsernameDialogCancelled extends UsernameDialogEvent {
  const UsernameDialogCancelled();

  @override
  List<Object> get props => [];
}
