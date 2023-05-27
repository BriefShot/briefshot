part of 'tag_pills_bloc.dart';

abstract class TagPillsState extends Equatable {
  const TagPillsState();

  @override
  List<Object> get props => [];
}

class TagPillsInitial extends TagPillsState {}

class TagPillsDeleteMode extends TagPillsState {}
