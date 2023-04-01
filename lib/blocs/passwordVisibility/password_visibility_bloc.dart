import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'password_visibility_event.dart';
part 'password_visibility_state.dart';

class PasswordVisibilityBloc
    extends Bloc<PasswordVisibilityEvent, PasswordVisibilityState> {
  PasswordVisibilityBloc()
      : super(
          const PasswordVisibilityState._(
            isHidden: true,
          ),
        ) {
    on<PressOnPasswordVisibilityButton>(
      (event, emit) {
        state.isHidden
            ? emit(const PasswordVisibilityState.isVisible())
            : emit(const PasswordVisibilityState.isHidden());
      },
    );
  }
}
