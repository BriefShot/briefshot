part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final bool isSignUpFormVisible;
  final bool isSignInFormVisible;
  final String? error;

  const AuthenticationState({
    this.error,
    this.isSignUpFormVisible = false,
    this.isSignInFormVisible = false,
  });

  @override
  List<Object?> get props => [error, isSignUpFormVisible, isSignInFormVisible];
}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationSignUpFormRequestedState extends AuthenticationState {
  const AuthenticationSignUpFormRequestedState()
      : super(isSignUpFormVisible: true);
}

class AuthenticationSignInFormRequestedState extends AuthenticationState {
  const AuthenticationSignInFormRequestedState()
      : super(isSignInFormVisible: true);
}

class AuthenticationSignUpSuccessfullyState extends AuthenticationState {
  const AuthenticationSignUpSuccessfullyState()
      : super(
          isSignInFormVisible: true,
        );
}

class AuthenticationSignUpFailedState extends AuthenticationState {
  final String error;
  const AuthenticationSignUpFailedState(this.error);
}

class AuthenticationSignInSuccessfullyState extends AuthenticationState {}

class AuthenticationSignInFailedState extends AuthenticationState {
  final String error;

  const AuthenticationSignInFailedState(this.error);
}
