part of 'user_infos_bloc.dart';

abstract class UserInfosEvent extends Equatable {
  const UserInfosEvent();

  @override
  List<Object> get props => [];
}

class LoadUserInfos extends UserInfosEvent {}

class UpdateUserInfos extends UserInfosEvent {
  final UserInfos userInfos;

  const UpdateUserInfos({required this.userInfos});

  @override
  List<Object> get props => [userInfos];
}
