import 'package:bloc/bloc.dart';
import 'package:briefshot/repository/UserInfosRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'username_dialog_event.dart';
part 'username_dialog_state.dart';

class UsernameDialogBloc
    extends Bloc<UsernameDialogEvent, UsernameDialogState> {
  UsernameDialogBloc() : super(UsernameDialogInitial()) {
    on<UsernameDialogAsked>((event, emit) {
      emit(UsernameDialogAppear());
    });
    on<UsernameDialogFieldChanged>((event, emit) {
      emit(UsernameDialogFieldUptadedValue(event.username));
    });
    on<UsernameDialogFieldSubmitted>((event, emit) async {
      try {
        await UserInfosRepository().updateUsername(event.username!);
        emit(UsernameDialogInitial());
      } catch (e) {
        emit(UsernameDialogError());
      }
      emit(UsernameDialogSubmitted(event.username!));
    });
    on<UsernameDialogCancelled>((event, emit) {
      emit(UsernameDialogInitial());
    });
  }
}
