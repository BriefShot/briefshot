part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileEditionAsked extends ProfileEvent {}

class ProfileEditionCancelled extends ProfileEvent {}

class ProfileAvatarUpdateAsked extends ProfileEvent {}

class ProfileCoverUpdateAsked extends ProfileEvent {}

class ProfileUsernameUpdateAsked extends ProfileEvent {}

class ProfileUpdateThrowError extends ProfileEvent {
  final String message;
  const ProfileUpdateThrowError({required this.message});
}
