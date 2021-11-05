import 'package:locatey/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyCyztGBbS0fKZ0KmzZ8TTZ6bsHLeW5ZILM';
  static String place = 'electricvehilcechargingstations';
  Future<List<Place>> getPlaces(double lat, double lng) async {
    var response = await http.get(
        //'https://maps.googleapis.com/maps/api/place/search/json?keyword=electricvehiclechargingstations&location=$lat,$lng&radius=50000&key=$key');
        'https://maps.googleapis.com/maps/api/place/search/json?keyword=evcharging&location=12.971599,77.594566&rankby=distance&key=$key');
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}

// 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?input=electricvehiclechargingstations&location=$lat,$lng&type=$place&rankby=distance&key=$key');
        //'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&query=electricvehiclechargingstations&radius=10000000&key=$key');
   // 'https://maps.googleapis.com/maps/api/place/queryautocomplete/json?input=electricvehiclechargingstations&location=$lat,$lng&radius=1000&types=establishment&key=$key');