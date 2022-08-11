// To parse this JSON data, do
//
//     final directions = directionsFromMap(jsonString);

import 'dart:convert';

Direction directionFromMap(String str) => Direction.fromMap(json.decode(str));

String directionToMap(Direction data) => json.encode(data.toMap());

class Direction {
  Direction({
    this.geocodedWaypoints,
    this.routes,
    this.status,
  });

  List<GeocodedWaypoint>? geocodedWaypoints;
  List<Route>? routes;
  String? status;

  factory Direction.fromMap(Map<String, dynamic> json) => Direction(
        geocodedWaypoints: json["geocoded_waypoints"] == null
            ? null
            : List<GeocodedWaypoint>.from(json["geocoded_waypoints"]
                .map((x) => GeocodedWaypoint.fromMap(x))),
        routes: json["routes"] == null
            ? null
            : List<Route>.from(json["routes"].map((x) => Route.fromMap(x))),
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toMap() => {
        "geocoded_waypoints": geocodedWaypoints == null
            ? null
            : List<dynamic>.from(geocodedWaypoints!.map((x) => x.toMap())),
        "routes": routes == null
            ? null
            : List<dynamic>.from(routes!.map((x) => x.toMap())),
        "status": status == null ? null : status,
      };
}

class GeocodedWaypoint {
  GeocodedWaypoint({
    this.geocoderStatus,
    this.placeId,
    this.types,
  });

  String? geocoderStatus;
  String? placeId;
  List<String>? types;

  factory GeocodedWaypoint.fromMap(Map<String, dynamic> json) =>
      GeocodedWaypoint(
        geocoderStatus:
            json["geocoder_status"] == null ? null : json["geocoder_status"],
        placeId: json["place_id"] == null ? null : json["place_id"],
        types: json["types"] == null
            ? null
            : List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "geocoder_status": geocoderStatus == null ? null : geocoderStatus,
        "place_id": placeId == null ? null : placeId,
        "types":
            types == null ? null : List<dynamic>.from(types!.map((x) => x)),
      };
}

class Route {
  Route({
    this.bounds,
    this.copyrights,
    this.legs,
    this.overviewPolyline,
    this.summary,
    this.warnings,
    this.waypointOrder,
  });

  Bounds? bounds;
  String? copyrights;
  List<Leg>? legs;
  Polyline? overviewPolyline;
  String? summary;
  List<String>? warnings;
  List<dynamic>? waypointOrder;

  factory Route.fromMap(Map<String, dynamic> json) => Route(
        bounds: json["bounds"] == null ? null : Bounds.fromMap(json["bounds"]),
        copyrights: json["copyrights"] == null ? null : json["copyrights"],
        legs: json["legs"] == null
            ? null
            : List<Leg>.from(json["legs"].map((x) => Leg.fromMap(x))),
        overviewPolyline: json["overview_polyline"] == null
            ? null
            : Polyline.fromMap(json["overview_polyline"]),
        summary: json["summary"] == null ? null : json["summary"],
        warnings: json["warnings"] == null
            ? null
            : List<String>.from(json["warnings"].map((x) => x)),
        waypointOrder: json["waypoint_order"] == null
            ? null
            : List<dynamic>.from(json["waypoint_order"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "bounds": bounds == null ? null : bounds!.toMap(),
        "copyrights": copyrights == null ? null : copyrights,
        "legs": legs == null
            ? null
            : List<dynamic>.from(legs!.map((x) => x.toMap())),
        "overview_polyline":
            overviewPolyline == null ? null : overviewPolyline!.toMap(),
        "summary": summary == null ? null : summary,
        "warnings": warnings == null
            ? null
            : List<dynamic>.from(warnings!.map((x) => x)),
        "waypoint_order": waypointOrder == null
            ? null
            : List<dynamic>.from(waypointOrder!.map((x) => x)),
      };
}

class Bounds {
  Bounds({
    this.northeast,
    this.southwest,
  });

  Northeast? northeast;
  Northeast? southwest;

  factory Bounds.fromMap(Map<String, dynamic> json) => Bounds(
        northeast: json["northeast"] == null
            ? null
            : Northeast.fromMap(json["northeast"]),
        southwest: json["southwest"] == null
            ? null
            : Northeast.fromMap(json["southwest"]),
      );

  Map<String, dynamic> toMap() => {
        "northeast": northeast == null ? null : northeast!.toMap(),
        "southwest": southwest == null ? null : southwest!.toMap(),
      };
}

class Northeast {
  Northeast({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory Northeast.fromMap(Map<String, dynamic> json) => Northeast(
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}

class Leg {
  Leg({
    this.arrivalTime,
    this.departureTime,
    this.distance,
    this.duration,
    this.endAddress,
    this.endLocation,
    this.startAddress,
    this.startLocation,
    this.steps,
    this.trafficSpeedEntry,
    this.viaWaypoint,
  });

  Time? arrivalTime;
  Time? departureTime;
  Distance? distance;
  Distance? duration;
  String? endAddress;
  Northeast? endLocation;
  String? startAddress;
  Northeast? startLocation;
  List<Step>? steps;
  List<dynamic>? trafficSpeedEntry;
  List<dynamic>? viaWaypoint;

  factory Leg.fromMap(Map<String, dynamic> json) => Leg(
        arrivalTime: json["arrival_time"] == null
            ? null
            : Time.fromMap(json["arrival_time"]),
        departureTime: json["departure_time"] == null
            ? null
            : Time.fromMap(json["departure_time"]),
        distance: json["distance"] == null
            ? null
            : Distance.fromMap(json["distance"]),
        duration: json["duration"] == null
            ? null
            : Distance.fromMap(json["duration"]),
        endAddress: json["end_address"] == null ? null : json["end_address"],
        endLocation: json["end_location"] == null
            ? null
            : Northeast.fromMap(json["end_location"]),
        startAddress:
            json["start_address"] == null ? null : json["start_address"],
        startLocation: json["start_location"] == null
            ? null
            : Northeast.fromMap(json["start_location"]),
        steps: json["steps"] == null
            ? null
            : List<Step>.from(json["steps"].map((x) => Step.fromMap(x))),
        trafficSpeedEntry: json["traffic_speed_entry"] == null
            ? null
            : List<dynamic>.from(json["traffic_speed_entry"].map((x) => x)),
        viaWaypoint: json["via_waypoint"] == null
            ? null
            : List<dynamic>.from(json["via_waypoint"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "arrival_time": arrivalTime == null ? null : arrivalTime!.toMap(),
        "departure_time": departureTime == null ? null : departureTime!.toMap(),
        "distance": distance == null ? null : distance?.toMap(),
        "duration": duration == null ? null : duration?.toMap(),
        "end_address": endAddress == null ? null : endAddress,
        "end_location": endLocation == null ? null : endLocation!.toMap(),
        "start_address": startAddress == null ? null : startAddress,
        "start_location": startLocation == null ? null : startLocation?.toMap(),
        "steps": steps == null
            ? null
            : List<dynamic>.from(steps!.map((x) => x.toMap())),
        "traffic_speed_entry": trafficSpeedEntry == null
            ? null
            : List<dynamic>.from(trafficSpeedEntry!.map((x) => x)),
        "via_waypoint": viaWaypoint == null
            ? null
            : List<dynamic>.from(viaWaypoint!.map((x) => x)),
      };
}

class Time {
  Time({
    this.text,
    this.timeZone,
    this.value,
  });

  String? text;
  TimeZone? timeZone;
  int? value;

  factory Time.fromMap(Map<String, dynamic> json) => Time(
        text: json["text"] == null ? null : json["text"],
        timeZone: json["time_zone"] == null
            ? null
            : timeZoneValues.map[json["time_zone"]],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toMap() => {
        "text": text == null ? null : text,
        "time_zone": timeZone == null ? null : timeZoneValues.reverse[timeZone],
        "value": value == null ? null : value,
      };
}

enum TimeZone { AMERICA_SANTO_DOMINGO }

final timeZoneValues =
    EnumValues({"America/Santo_Domingo": TimeZone.AMERICA_SANTO_DOMINGO});

class Distance {
  Distance({
    this.text,
    this.value,
  });

  String? text;
  int? value;

  factory Distance.fromMap(Map<String, dynamic> json) => Distance(
        text: json["text"] == null ? null : json["text"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toMap() => {
        "text": text == null ? null : text,
        "value": value == null ? null : value,
      };
}

class Step {
  Step({
    this.distance,
    this.duration,
    this.endLocation,
    this.htmlInstructions,
    this.polyline,
    this.startLocation,
    this.steps,
    this.travelMode,
    this.transitDetails,
    this.maneuver,
  });

  Distance? distance;
  Distance? duration;
  Northeast? endLocation;
  String? htmlInstructions;
  Polyline? polyline;
  Northeast? startLocation;
  List<Step>? steps;
  TravelMode? travelMode;
  TransitDetails? transitDetails;
  Maneuver? maneuver;

  factory Step.fromMap(Map<String, dynamic> json) => Step(
        distance: json["distance"] == null
            ? null
            : Distance.fromMap(json["distance"]),
        duration: json["duration"] == null
            ? null
            : Distance.fromMap(json["duration"]),
        endLocation: json["end_location"] == null
            ? null
            : Northeast.fromMap(json["end_location"]),
        htmlInstructions: json["html_instructions"] == null
            ? null
            : json["html_instructions"],
        polyline: json["polyline"] == null
            ? null
            : Polyline.fromMap(json["polyline"]),
        startLocation: json["start_location"] == null
            ? null
            : Northeast.fromMap(json["start_location"]),
        steps: json["steps"] == null
            ? null
            : List<Step>.from(json["steps"].map((x) => Step.fromMap(x))),
        travelMode: json["travel_mode"] == null
            ? null
            : travelModeValues.map[json["travel_mode"]],
        transitDetails: json["transit_details"] == null
            ? null
            : TransitDetails.fromMap(json["transit_details"]),
        maneuver: json["maneuver"] == null
            ? null
            : maneuverValues.map[json["maneuver"]],
      );

  Map<String, dynamic> toMap() => {
        "distance": distance == null ? null : distance!.toMap(),
        "duration": duration == null ? null : duration!.toMap(),
        "end_location": endLocation == null ? null : endLocation!.toMap(),
        "html_instructions": htmlInstructions == null ? null : htmlInstructions,
        "polyline": polyline == null ? null : polyline!.toMap(),
        "start_location": startLocation == null ? null : startLocation!.toMap(),
        "steps": steps == null
            ? null
            : List<dynamic>.from(steps!.map((x) => x.toMap())),
        "travel_mode":
            travelMode == null ? null : travelModeValues.reverse[travelMode],
        "transit_details":
            transitDetails == null ? null : transitDetails!.toMap(),
        "maneuver": maneuver == null ? null : maneuverValues.reverse[maneuver],
      };
}

enum Maneuver { TURN_LEFT, TURN_RIGHT }

final maneuverValues = EnumValues(
    {"turn-left": Maneuver.TURN_LEFT, "turn-right": Maneuver.TURN_RIGHT});

class Polyline {
  Polyline({
    this.points,
  });

  String? points;

  factory Polyline.fromMap(Map<String, dynamic> json) => Polyline(
        points: json["points"] == null ? null : json["points"],
      );

  Map<String, dynamic> toMap() => {
        "points": points == null ? null : points,
      };
}

class TransitDetails {
  TransitDetails({
    this.arrivalStop,
    this.arrivalTime,
    this.departureStop,
    this.departureTime,
    this.headsign,
    this.line,
    this.numStops,
  });

  Stop? arrivalStop;
  Time? arrivalTime;
  Stop? departureStop;
  Time? departureTime;
  String? headsign;
  Line? line;
  int? numStops;

  factory TransitDetails.fromMap(Map<String, dynamic> json) => TransitDetails(
        arrivalStop: json["arrival_stop"] == null
            ? null
            : Stop.fromMap(json["arrival_stop"]),
        arrivalTime: json["arrival_time"] == null
            ? null
            : Time.fromMap(json["arrival_time"]),
        departureStop: json["departure_stop"] == null
            ? null
            : Stop.fromMap(json["departure_stop"]),
        departureTime: json["departure_time"] == null
            ? null
            : Time.fromMap(json["departure_time"]),
        headsign: json["headsign"] == null ? null : json["headsign"],
        line: json["line"] == null ? null : Line.fromMap(json["line"]),
        numStops: json["num_stops"] == null ? null : json["num_stops"],
      );

  Map<String, dynamic> toMap() => {
        "arrival_stop": arrivalStop == null ? null : arrivalStop!.toMap(),
        "arrival_time": arrivalTime == null ? null : arrivalTime!.toMap(),
        "departure_stop": departureStop == null ? null : departureStop!.toMap(),
        "departure_time": departureTime == null ? null : departureTime!.toMap(),
        "headsign": headsign == null ? null : headsign,
        "line": line == null ? null : line!.toMap(),
        "num_stops": numStops == null ? null : numStops,
      };
}

class Stop {
  Stop({
    this.location,
    this.name,
  });

  Northeast? location;
  String? name;

  factory Stop.fromMap(Map<String, dynamic> json) => Stop(
        location: json["location"] == null
            ? null
            : Northeast.fromMap(json["location"]),
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "location": location == null ? null : location!.toMap(),
        "name": name == null ? null : name,
      };
}

class Line {
  Line({
    this.agencies,
    this.color,
    this.name,
    this.shortName,
    this.textColor,
    this.vehicle,
  });

  List<Agency>? agencies;
  String? color;
  String? name;
  String? shortName;
  String? textColor;
  Vehicle? vehicle;

  factory Line.fromMap(Map<String, dynamic> json) => Line(
        agencies: json["agencies"] == null
            ? null
            : List<Agency>.from(json["agencies"].map((x) => Agency.fromMap(x))),
        color: json["color"] == null ? null : json["color"],
        name: json["name"] == null ? null : json["name"],
        shortName: json["short_name"] == null ? null : json["short_name"],
        textColor: json["text_color"] == null ? null : json["text_color"],
        vehicle:
            json["vehicle"] == null ? null : Vehicle.fromMap(json["vehicle"]),
      );

  Map<String, dynamic> toMap() => {
        "agencies": agencies == null
            ? null
            : List<dynamic>.from(agencies!.map((x) => x.toMap())),
        "color": color == null ? null : color,
        "name": name == null ? null : name,
        "short_name": shortName == null ? null : shortName,
        "text_color": textColor == null ? null : textColor,
        "vehicle": vehicle == null ? null : vehicle!.toMap(),
      };
}

class Agency {
  Agency({
    this.name,
    this.phone,
    this.url,
  });

  String? name;
  String? phone;
  String? url;

  factory Agency.fromMap(Map<String, dynamic> json) => Agency(
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "url": url == null ? null : url,
      };
}

class Vehicle {
  Vehicle({
    this.icon,
    this.name,
    this.type,
  });

  String? icon;
  String? name;
  String? type;

  factory Vehicle.fromMap(Map<String, dynamic> json) => Vehicle(
        icon: json["icon"] == null ? null : json["icon"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toMap() => {
        "icon": icon == null ? null : icon,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
      };
}

enum TravelMode { WALKING, TRANSIT }

final travelModeValues =
    EnumValues({"TRANSIT": TravelMode.TRANSIT, "WALKING": TravelMode.WALKING});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
