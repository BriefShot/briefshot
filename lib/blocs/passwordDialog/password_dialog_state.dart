part of 'password_dialog_bloc.dart';

abstract class PasswordDialogState extends Equatable {
  final String? password;
  const PasswordDialogState(this.password);

  @override
  List<Object?> get props => [password];
}

class PasswordDialogInitial extends PasswordDialogState {
  const PasswordDialogInitial() : super(null);

  @override
  List<Object> get props => [];
}

class PasswordDialogAppear extends PasswordDialogState {
  @override
  late String? password;
  PasswordDialogAppear() : super(null);

  @override
  List<Object> get props => [];
}

class PasswordDialogFieldUptadedValue extends PasswordDialogState {
  @override
  final String password;

  const PasswordDialogFieldUptadedValue(this.password) : super(password);

  @override
  List<Object> get props => [password];
}

class PasswordDialogSubmitted extends PasswordDialogState {
  @override
  final String password;

  const PasswordDialogSubmitted(this.password) : super(password);

  @override
  List<Object> get props => [password];
}

class PasswordDialogWrongPasswordValue extends PasswordDialogState {
  final uuid = const Uuid().v4();
  PasswordDialogWrongPasswordValue() : super(null);

  @override
  List<Object> get props => [uuid];
}

class PasswordDialogValueOk extends PasswordDialogState {
  @override
  final String password;
  const PasswordDialogValueOk(this.password) : super(password);

  @override
  List<Object> get props => [password];
}
