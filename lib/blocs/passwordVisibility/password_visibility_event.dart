part of 'password_visibility_bloc.dart';

abstract class PasswordVisibilityEvent extends Equatable {
  const PasswordVisibilityEvent();

  @override
  List<Object> get props => [];
}

class PressOnPasswordVisibilityButton extends PasswordVisibilityEvent {
  final bool isHidden;

  const PressOnPasswordVisibilityButton({
    required this.isHidden,
  });
}
