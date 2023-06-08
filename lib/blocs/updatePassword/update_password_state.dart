part of 'update_password_bloc.dart';

abstract class UpdatePasswordState extends Equatable {
  const UpdatePasswordState();

  @override
  List<Object> get props => [];
}

class UpdatePasswordInitial extends UpdatePasswordState {}

class UpdatePasswordSuccessfully extends UpdatePasswordState {}

class UpdatePasswordUnsuccessful extends UpdatePasswordState {}
