import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repository/UserRepository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitialState()) {
    on<PressOnSignUpButton>((event, emit) async {
      try {
        await UserRepository().signUp(
          email: event.email,
          password: event.password,
        );
        emit(const AuthenticationSignUpSuccessfullyState());
      } catch (e) {
        emit(AuthenticationSignUpFailedState(e.toString()));
      }
    });
    on<PressOnSignInButton>((event, emit) async {
      try {
        await UserRepository().signIn(
          email: event.email,
          password: event.password,
        );
        emit(AuthenticationSignInSuccessfullyState());
      } catch (e) {
        emit(AuthenticationSignInFailedState(e.toString()));
      }
    });
    on<PressOnEmailSignUpButton>((event, emit) {
      emit(const AuthenticationSignUpFormRequestedState());
    });
    on<PressOnAlreadySignUpButton>((event, emit) {
      emit(const AuthenticationSignInFormRequestedState());
    });
    on<PressOnBackToSignUpMethodsButton>((event, emit) {
      emit(AuthenticationInitialState());
    });
  }
}
