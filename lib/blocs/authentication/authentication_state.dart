part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final bool isSignUpFormVisible;
  final bool isSignInFormVisible;

  const AuthenticationState._(
      {required this.isSignUpFormVisible, required this.isSignInFormVisible});

  const AuthenticationState.formVisible()
      : this._(isSignUpFormVisible: true, isSignInFormVisible: false);
  const AuthenticationState.formHidden()
      : this._(isSignUpFormVisible: false, isSignInFormVisible: false);
  const AuthenticationState.signInFormRequested()
      : this._(isSignUpFormVisible: false, isSignInFormVisible: true);

  @override
  List<Object> get props => [isSignUpFormVisible, isSignInFormVisible];
}
