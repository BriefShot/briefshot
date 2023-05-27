import 'package:bloc/bloc.dart';
import 'package:briefshot/repository/UserRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'password_dialog_event.dart';
part 'password_dialog_state.dart';

class PasswordDialogBloc
    extends Bloc<PasswordDialogEvent, PasswordDialogState> {
  PasswordDialogBloc() : super(const PasswordDialogInitial()) {
    on<PasswordDialogAsked>((event, emit) {
      emit(PasswordDialogAppear());
    });
    on<PasswordDialogFieldChanged>((event, emit) {
      emit(PasswordDialogFieldUptadedValue(event.password));
    });
    on<PasswordDialogFieldSubmitted>((event, emit) async {
      try {
        await UserRepository().relogUser(event.password!);
        emit(PasswordDialogValueOk(event.password!));
      } catch (e) {
        emit(PasswordDialogWrongPasswordValue());
      }
    });
    on<PasswordDialogCancelled>((event, emit) {
      emit(const PasswordDialogInitial());
    });
  }
}
