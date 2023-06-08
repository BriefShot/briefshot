import 'package:bloc/bloc.dart';
import 'package:briefshot/services/AutoCompleteService.dart';
import 'package:briefshot/services/MapService.dart';
import 'package:equatable/equatable.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<LocationSearch>((event, emit) async {
      List<Prediction> predictions =
          await AutoCompleteService.getPredictions(event.input);
      emit(LocationPredictionsLoaded(predictions: predictions));
    });
    on<LocationPredictionSelected>((event, emit) async {
      Location location = await AutoCompleteService.getCoordinatesFromAddress(
          event.prediction.description!);

      emit(LocationSelected(location: location));
    });
  }
}
