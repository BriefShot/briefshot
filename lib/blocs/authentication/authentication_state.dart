part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final bool isSignUpFormVisible;
  final bool isSignInFormVisible;

  const AuthenticationState._(
      {required this.isSignUpFormVisible,
      required this.isSignInFormVisible,
      bool? signUpSuccessfully});

  const AuthenticationState.formVisible()
      : this._(isSignUpFormVisible: true, isSignInFormVisible: false);
  const AuthenticationState.formHidden()
      : this._(isSignUpFormVisible: false, isSignInFormVisible: false);
  const AuthenticationState.signInFormRequested()
      : this._(isSignUpFormVisible: false, isSignInFormVisible: true);
  const AuthenticationState.signUpSuccessfully()
      : this._(
          isSignUpFormVisible: false,
          isSignInFormVisible: true,
        );

  const AuthenticationState.signInSuccessfully()
      : this._(
          isSignUpFormVisible: false,
          isSignInFormVisible: false,
        );

  @override
  List<Object> get props => [isSignUpFormVisible, isSignInFormVisible];
}
