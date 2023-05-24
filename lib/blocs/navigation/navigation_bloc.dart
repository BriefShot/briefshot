import 'package:bloc/bloc.dart';
import 'package:briefshot/blocs/userInfos/user_infos_bloc.dart';
import 'package:briefshot/repository/UserInfosRepository.dart';
import 'package:briefshot/screens/MapScreen.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/MessageScreen.dart';
import '../../screens/NotificationScreen.dart';
import '../../screens/ProfileScreen.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final UserInfosBloc userInfosBloc;

  NavigationBloc(this.userInfosBloc)
      : super(
          NavigationState(
            currentTabIndex: 0,
            screens: [
              const MapScreen(),
              const MessageScreen(),
              BlocProvider.value(
                  value: userInfosBloc, child: const ProfileScreen()),
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
