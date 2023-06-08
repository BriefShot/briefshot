import 'package:bloc/bloc.dart';
import 'package:briefshot/repository/UserRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc
    extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  UpdatePasswordBloc() : super(UpdatePasswordInitial()) {
    on<UpdatePasswordEvent>((event, emit) async {
      try {
        await UserRepository().updatePassword(event.newPassword);
        emit(UpdatePasswordSuccessfully());
      } catch (e) {
        emit(UpdatePasswordUnsuccessful());
      }
    });
  }
}
