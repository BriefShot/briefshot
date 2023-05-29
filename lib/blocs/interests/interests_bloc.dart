import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:briefshot/entities/Interest.dart';
import 'package:briefshot/repository/InterestRepository.dart';
import 'package:briefshot/repository/UserInfosRepository.dart';
import 'package:equatable/equatable.dart';

part 'interests_event.dart';
part 'interests_state.dart';

class InterestsBloc extends Bloc<InterestsEvent, InterestsState> {
  final InterestRepository _interestRepository;
  StreamSubscription? _interestsSubscription;

  InterestsBloc(this._interestRepository) : super(InterestsLoading()) {
    on<LoadInterests>((event, emit) {
      _interestsSubscription?.cancel();
      _interestsSubscription =
          _interestRepository.getInterests().listen((interests) {
        add(UpdateInterests(interests: interests));
      });
    });
    on<UpdateInterests>((event, emit) {
      emit(InterestsLoaded(
        interests: event.interests,
        interestsSelected: [],
      ));
    });

    on<SelectInterest>((event, emit) {
      emit(InterestsLoaded(interests: event.interests, interestsSelected: [
        ...event.currentSelectedInterests,
        event.interestSelected
      ]));
    });

    on<UnselectInterest>((event, emit) {
      var updatedSelectedInterests =
          List<Interest>.from(event.currentSelectedInterests);
      updatedSelectedInterests.remove(event.unselectedInterest);
      emit(InterestsLoaded(
        interests: event.interests,
        interestsSelected: updatedSelectedInterests,
      ));
    });

    on<SubmitInterests>((event, emit) {
      List<String> labels =
          event.interestsToSubmit.map((interest) => interest.label).toList();

      try {
        UserInfosRepository().addTags(labels);
      } catch (e) {
        rethrow;
      }
      emit(
        InterestsSubmitted(),
      );
    });
  }
}
