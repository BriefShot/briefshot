part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class PressOnSignUpButton extends AuthenticationEvent {
  final String email;
  final String password;

  const PressOnSignUpButton({
    required this.email,
    required this.password,
  });
}

class PressOnEmailSignUpButton extends AuthenticationEvent {}

class PressOnSignInButton extends AuthenticationEvent {}

class PressOnBackToSignUpButton extends AuthenticationEvent {}

class PressOnBackToSignUpMethodsButton extends AuthenticationEvent {}
