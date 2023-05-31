import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class AutoCompleteService {
  static Future<List<Prediction>> getPredictions(String input) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=AIzaSyAn-dV0zs0L8G4h1eRtO0usNds6jX5-G74";
    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body);
    final predictions = json["predictions"] as List;
    return predictions.map((e) => Prediction.fromJson(e)).toList();
  }

  static Future<Location> getCoordinatesFromAddress(String adress) async {
    final result = await GoogleMapsPlaces(
            apiKey: 'AIzaSyAn-dV0zs0L8G4h1eRtO0usNds6jX5-G74')
        .searchByText(adress);

    if (result.status == 'OK' && result.results.isNotEmpty) {
      final location = result.results.first.geometry?.location;
      if (location != null) {
        print("${location.lat} & ${location.lng}");
        return location;
      } else {
        throw Exception('No location found');
      }
    }
    throw Exception('No location found');
  }
}
