part of 'interests_bloc.dart';

abstract class InterestsState extends Equatable {
  const InterestsState();

  @override
  List<Object> get props => [];
}

class InterestsInitial extends InterestsState {}

class InterestsLoading extends InterestsState {}

class InterestsLoaded extends InterestsState {
  final List<Interest> interests;
  final List<Interest> interestsSelected;

  InterestsLoaded({required this.interests, required this.interestsSelected});

  @override
  List<Object> get props => [interests, interestsSelected];
}

class InterestsUpdated extends InterestsState {
  final List<Interest> interests;

  const InterestsUpdated({required this.interests});

  @override
  List<Object> get props => [interests];
}

class InterestsSubmitted extends InterestsState {}
