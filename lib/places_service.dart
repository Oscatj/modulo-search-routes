import 'package:google_place/google_place.dart';

const API_KEY = "AIzaSyACdmw-JbmAHVCQHf_ytMSK6DthpRwe6g0";

Future<List<SearchResult>?> getPlaces(double lat, double lng) async {
  var googlePlace = GooglePlace(API_KEY);
  var result = await googlePlace.search
      .getNearBySearch(Location(lat: lat, lng: lng), 3000, type: "bus_station");

  // print(result!.status);
  if (result!.status == 'OK') {
    // result.results!.forEach((element) {
    //   print(element.name);
    // });
    return result.results != null ? result.results : [];
  }
}
