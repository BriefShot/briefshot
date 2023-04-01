part of 'password_visibility_bloc.dart';

class PasswordVisibilityState extends Equatable {
  final bool isHidden;

  const PasswordVisibilityState._({required this.isHidden});

  const PasswordVisibilityState.isVisible()
      : this._(
          isHidden: false,
        );

  const PasswordVisibilityState.isHidden()
      : this._(
          isHidden: true,
        );

  @override
  List<Object> get props => [isHidden];
}
