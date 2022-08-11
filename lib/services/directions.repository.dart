import 'package:dio/dio.dart';
import 'package:places_test/models/direction.dart';

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';
  static const API_KEY = "AIzaSyACdmw-JbmAHVCQHf_ytMSK6DthpRwe6g0";

  final Dio _dio = Dio();

  Future<Direction> getDirections(String origin, String destination) async {
    // Response response = await _dio.get(
    //     'https://maps.googleapis.com/maps/api/directions/json?origin=Av. Núñez de Cáceres, Santo Domingo&destination=Av. México, Santo Domingo 10201&mode=transit&key=AIzaSyACdmw-JbmAHVCQHf_ytMSK6DthpRwe6g0&alternatives=true');

    var response = await _dio.get(_baseUrl, queryParameters: {
      'origin': origin,
      'destination': destination,
      'alternatives': 'true',
      'mode': 'transit',
      'language': 'es',
      'key': API_KEY,
    });

    var data = Direction.fromMap(response.data);
    // var routes = response.data['routes'];
    // print(data.routes.length);
    // data.routes.forEach((route) {
    //   print('Route 1 =======================');
    //   route.legs.forEach((leg) {
    //     print('|-Steps --------');
    //     leg.steps.forEach((step) {
    //       print('|  ${step.distance.text}');
    //       print('|  ${step.duration.text}');
    //       print('|  ${step.travelMode.toString()}');
    //       print('|____');
    //     });
    //   });
    // });

    return data;
  }
}
