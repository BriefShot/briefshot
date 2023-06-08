part of 'update_password_bloc.dart';

class UpdatePasswordEvent extends Equatable {
  final String newPassword;
  const UpdatePasswordEvent(this.newPassword);

  @override
  List<Object> get props => [];
}
