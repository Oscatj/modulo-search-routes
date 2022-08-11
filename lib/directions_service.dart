import 'package:google_directions_api/google_directions_api.dart';

const API_KEY = "AIzaSyACdmw-JbmAHVCQHf_ytMSK6DthpRwe6g0";

Future<void> getDirections() async {
  DirectionsService.init(API_KEY);

  final directionsService = DirectionsService();

  // const request = DirectionsRequest(
  //   origin: 'Av. Winston Churchill, Santo Domingo',
  //   destination: 'Lorenzo Despradel, Santo Domingo',
  //   travelMode: TravelMode.transit,
  //   alternatives: true,
  // );

  // const request = DirectionsRequest(
  //   origin: '18.467995,-69.939190',
  //   destination: '18.470559,-69.944082',
  //   travelMode: TravelMode.transit,
  //   alternatives: true,
  // );

  const request = DirectionsRequest(
    origin: 'Av. Núñez de Cáceres, Santo Domingo',
    destination: 'Av. México, Santo Domingo 10201',
    travelMode: TravelMode.transit,
    alternatives: false,
  );

  directionsService.route(request, (DirectionsResult response, status) async {
    if (status == DirectionsStatus.ok) {
      // do something with successful response
      print(response.routes!.length.toString());
    } else {
      // do something with error response
    }
  });
}
