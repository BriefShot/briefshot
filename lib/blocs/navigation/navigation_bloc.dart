import 'package:bloc/bloc.dart';
import 'package:briefshot/screens/MapScreen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../screens/MessageScreen.dart';
import '../../screens/NotificationScreen.dart';
import '../../screens/ProfileScreen.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc()
      : super(
          const NavigationState(
            currentTabIndex: 0,
            screens: [
              MapScreen(),
              MessageScreen(),
              ProfileScreen(),
              NotificationScreen()
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
