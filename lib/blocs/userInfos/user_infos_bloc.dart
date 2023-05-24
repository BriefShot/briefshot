import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:briefshot/entities/UserInfos.dart';
import 'package:briefshot/repository/UserInfosRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_infos_event.dart';
part 'user_infos_state.dart';

class UserInfosBloc extends Bloc<UserInfosEvent, UserInfosState> {
  final UserInfosRepository _userInfosRepository;
  StreamSubscription? _userInfosSubscription;

  UserInfosBloc(this._userInfosRepository) : super(UserInfosLoading()) {
    on<LoadUserInfos>((event, emit) {
      // print(_userInfosSubscription!.isPaused);
      _userInfosSubscription?.cancel();
      _userInfosSubscription = _userInfosRepository
          .getUserInfos(FirebaseAuth.instance.currentUser!.uid)
          .listen((userInfos) => add(UpdateUserInfos(userInfos: userInfos)));
    });

    on<UpdateUserInfos>((event, emit) {
      emit(UserInfosLoaded(userInfos: event.userInfos));
    });
  }
}
