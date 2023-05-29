part of 'interests_bloc.dart';

abstract class InterestsEvent extends Equatable {
  const InterestsEvent();

  @override
  List<Object> get props => [];
}

class LoadInterests extends InterestsEvent {}

class UpdateInterests extends InterestsEvent {
  final List<Interest> interests;

  UpdateInterests({required this.interests});

  @override
  List<Object> get props => [interests];
}

class SelectInterest extends InterestsEvent {
  final List<Interest> interests;
  final List<Interest> currentSelectedInterests;
  final Interest interestSelected;

  SelectInterest(
      {required this.currentSelectedInterests,
      required this.interests,
      required this.interestSelected});

  @override
  List<Object> get props => [interests, interestSelected];
}

class UnselectInterest extends InterestsEvent {
  final List<Interest> interests;
  final List<Interest> currentSelectedInterests;
  final Interest unselectedInterest;

  UnselectInterest(
      {required this.currentSelectedInterests,
      required this.interests,
      required this.unselectedInterest});

  @override
  List<Object> get props => [interests, unselectedInterest];
}

class SubmitInterests extends InterestsEvent {
  final List<Interest> interestsToSubmit;

  SubmitInterests({required this.interestsToSubmit});

  @override
  List<Object> get props => [interestsToSubmit];
}
