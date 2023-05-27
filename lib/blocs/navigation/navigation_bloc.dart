import 'package:briefshot/blocs/profile/profile_bloc.dart';
import 'package:briefshot/blocs/userInfos/user_infos_bloc.dart';
import 'package:briefshot/blocs/usernameDialog/username_dialog_bloc.dart';
import 'package:briefshot/screens/MapScreen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/MessageScreen.dart';
import '../../screens/NotificationScreen.dart';
import '../../screens/ProfileScreen.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final UserInfosBloc userInfosBloc;
  final ProfileBloc profileBloc;
  final UsernameDialogBloc usernameDialogBloc;

  NavigationBloc(this.userInfosBloc, this.profileBloc, this.usernameDialogBloc)
      : super(
          NavigationState(
            currentTabIndex: 0,
            screens: [
              MapScreen(),
              const MessageScreen(),
              MultiBlocProvider(providers: [
                BlocProvider.value(
                  value: userInfosBloc,
                ),
                BlocProvider.value(
                  value: profileBloc,
                ),
                BlocProvider.value(
                  value: usernameDialogBloc,
                ),
              ], child: const ProfileScreen()),
              const NotificationScreen()
            ],
          ),
        ) {
    on<NavigationTabChanged>((event, emit) {
      emit(
        NavigationState(
            currentTabIndex: event.tabIndex, screens: state.screens),
      );
    });
  }
}
