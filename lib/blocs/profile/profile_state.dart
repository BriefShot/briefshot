part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  bool isEditionMode = false;
  ProfileState({this.isEditionMode = false});

  @override
  List<Object> get props => [isEditionMode];
}

class ProfileInitial extends ProfileState {
  ProfileInitial() : super(isEditionMode: false);
}

class ProfileToggleEdition extends ProfileState {
  ProfileToggleEdition() : super(isEditionMode: true);
}

class ProfileAvatarUpdated extends ProfileState {
  ProfileAvatarUpdated() : super(isEditionMode: true);
}

class ProfileCoverUpdated extends ProfileState {
  ProfileCoverUpdated() : super(isEditionMode: true);
}

class ProfileUsernameUpdated extends ProfileState {
  ProfileUsernameUpdated() : super(isEditionMode: true);
}

class ProfileInterestsTagUpdated extends ProfileState {
  ProfileInterestsTagUpdated() : super(isEditionMode: true);
}

class ProfileUpdateError extends ProfileState {
  final String message;
  ProfileUpdateError({required this.message}) : super(isEditionMode: true);
}
