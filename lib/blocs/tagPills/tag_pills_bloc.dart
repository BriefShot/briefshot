import 'package:bloc/bloc.dart';
import 'package:briefshot/repository/UserInfosRepository.dart';
import 'package:equatable/equatable.dart';

part 'tag_pills_event.dart';
part 'tag_pills_state.dart';

class TagPillsBloc extends Bloc<TagPillsEvent, TagPillsState> {
  TagPillsBloc() : super(TagPillsInitial()) {
    on<TagPillsLongPressed>((event, emit) {
      emit(TagPillsDeleteMode());
    });
    on<TagPillsDeleteAsked>((event, emit) {
      UserInfosRepository().removeTag(event.tag);
      emit(TagPillsInitial());
    });
  }
}
