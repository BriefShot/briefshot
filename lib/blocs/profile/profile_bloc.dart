import 'package:bloc/bloc.dart';
import 'package:briefshot/repository/FirebaseStorageRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

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
    on<ProfileAvatarUpdateAsked>((event, emit) async {
      XFile? image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, requestFullMetadata: false);

      try {
        await FirebaseStorageRepository().uploadUserAvatarPicture(image!.path);
      } catch (e) {
        emit(ProfileUpdateError(message: "Une erreur est survenue"));
      }
      emit(ProfileAvatarUpdated());
    });

    on<ProfileCoverUpdateAsked>((event, emit) async {
      XFile? image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, requestFullMetadata: false);

      try {
        await FirebaseStorageRepository().uploadUserCoverPicture(image!.path);
      } catch (e) {
        emit(ProfileUpdateError(message: "Une erreur est survenue"));
      }
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
