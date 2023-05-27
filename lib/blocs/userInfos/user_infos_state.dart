part of 'user_infos_bloc.dart';

abstract class UserInfosState extends Equatable {
  const UserInfosState();

  @override
  List<Object> get props => [];
}

class UserInfosLoading extends UserInfosState {}

class UserInfosLoaded extends UserInfosState {
  final UserInfos userInfos;

  const UserInfosLoaded({required this.userInfos});

  @override
  List<Object> get props => [userInfos];
}
