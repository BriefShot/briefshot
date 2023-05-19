part of 'password_dialog_bloc.dart';

abstract class PasswordDialogEvent extends Equatable {
  const PasswordDialogEvent();

  @override
  List<Object> get props => [];
}

class PasswordDialogAsked extends PasswordDialogEvent {
  const PasswordDialogAsked();
}

class PasswordDialogFieldChanged extends PasswordDialogEvent {
  final String password;

  const PasswordDialogFieldChanged(this.password);

  @override
  List<Object> get props => [password];
}

class PasswordDialogFieldSubmitted extends PasswordDialogEvent {
  final String? password;
  const PasswordDialogFieldSubmitted(this.password);

  @override
  List<Object> get props => [];
}

class PasswordDialogCancelled extends PasswordDialogEvent {
  const PasswordDialogCancelled();

  @override
  List<Object> get props => [];
}
