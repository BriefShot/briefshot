import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AutoCompleteService {
  static Future<List<Prediction>> getPredictions(String input) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=${dotenv.env['MAPS_API_KEY']}";
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
        return location;
      } else {
        throw Exception('No location found');
      }
    }
    throw Exception('No location found');
  }
}
