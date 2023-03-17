import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/UserRepository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc()
      : super(
          const AuthenticationState._(
            isSignUpFormVisible: false,
            isSignInFormVisible: false,
          ),
        ) {
    on<PressOnEmailSignUpButton>((event, emit) {
      emit(const AuthenticationState.formVisible());
    });
    on<PressOnSignInButton>((event, emit) {
      emit(const AuthenticationState.signInFormRequested());
    });
    on<PressOnBackToSignUpButton>((event, emit) {
      emit(const AuthenticationState.formVisible());
    });
    on<PressOnBackToSignUpMethodsButton>((event, emit) {
      print("j'y passe ");
      emit(const AuthenticationState.formHidden());
    });
    on<PressOnSignUpButton>((event, emit) async {
      try {
        UserRepository().signUp(
          email: event.email,
          password: event.password,
          data: {
            "username": await UserRepository().generatedUniqueUsername(),
          },
        );
      } on Exception catch (e) {
        null;
      }
    });
  }
}