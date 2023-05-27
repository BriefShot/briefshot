part of 'tag_pills_bloc.dart';

abstract class TagPillsEvent extends Equatable {
  const TagPillsEvent();

  @override
  List<Object> get props => [];
}

class TagPillsLongPressed extends TagPillsEvent {}

class TagPillsDeleteAsked extends TagPillsEvent {
  final String tag;

  const TagPillsDeleteAsked({required this.tag});

  @override
  List<Object> get props => [tag];
}

class TagPillsCancelDeleteMode extends TagPillsEvent {}
