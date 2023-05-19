part of 'update_email_bloc.dart';

class UpdateEmailEvent extends Equatable {
  final String newEmail;
  const UpdateEmailEvent(this.newEmail);

  @override
  List<Object> get props => [];
}
