import 'package:bloc/bloc.dart';
import 'package:briefshot/repository/UserRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'update_email_event.dart';
part 'update_email_state.dart';

class UpdateEmailBloc extends Bloc<UpdateEmailEvent, UpdateEmailState> {
  UpdateEmailBloc()
      : super(UpdateEmailInitial(FirebaseAuth.instance.currentUser!.email!)) {
    on<UpdateEmailEvent>((event, emit) async {
      try {
        await UserRepository().updateEmail(event.newEmail);
        emit(UpdateEmailSuccessfully());
      } catch (e) {
        emit(UpdateEmailUnsuccessfull());
      }
    });
  }
}
