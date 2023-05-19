part of 'update_email_bloc.dart';

class UpdateEmailState extends Equatable {
  final String? email;
  const UpdateEmailState({this.email});

  @override
  List<Object?> get props => [email];
}

class UpdateEmailInitial extends UpdateEmailState {
  final String email;

  const UpdateEmailInitial(this.email);

  @override
  List<Object> get props => [email];
}

class UpdateEmailSuccessfully extends UpdateEmailState {}

class UpdateEmailUnsuccessfull extends UpdateEmailState {}
