import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEditionAsked>((event, emit) {
      emit(ProfileToggleEdition());
    });
    on<ProfileEditionCancelled>((event, emit) {
      emit(ProfileInitial());
    });
    on<ProfileAvatarUpdateAsked>((event, emit) {
      emit(ProfileAvatarUpdated());
    });
    on<ProfileCoverUpdateAsked>((event, emit) {
      emit(ProfileCoverUpdated());
    });
    on<ProfileUsernameUpdateAsked>((event, emit) {
      emit(ProfileUsernameUpdated());
    });
    on<ProfileUpdateThrowError>((event, emit) {
      emit(ProfileUpdateError(message: event.message));
    });
  }
}
