import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// ignore: depend_on_referenced_packages
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_test/services/location_services.dart';
import 'package:uuid/uuid.dart';

class Solicitud extends StatefulWidget {
  @override
  State<Solicitud> createState() => SolicitudState();
}

class SolicitudState extends State<Solicitud> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  
  var uui = Uuid();
  String _sessionToken = '12345';

  Set<Marker>_markers = Set<Marker>();
  Set<Polygon>_polygons = Set<Polygon>();
  Set<Polyline>_polylines = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState(){
    super.initState();

    _originController.addListener(() {
      //onChange();
    });
    _setMarker(LatLng(37.42796133580664, -122.085749655962));
  }

  void _setMarker(LatLng point){
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker'), 
          position: point,
        ),
      );
    });
  }
  void _setPolygon (){
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        fillColor: Colors.transparent,
      )
    );
  }
  void _setPolyline(List<PointLatLng>points){
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 4,
        color: Colors.red,
        points: points
        .map (
          (points) => LatLng(points.latitude, points.longitude),
        )
        .toList(),
        ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Solicitud'),),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _originController,
                      decoration: InputDecoration(hintText: 'Origen'),
                      onChanged: (value) {
                        print(value);
                      }
                    ),
                    TextFormField(
                      controller: _destinationController,
                      decoration: InputDecoration(hintText: 'Destino'),
                      onChanged: (value) {
                        print(value);
                      }
                    )
                  ],
               ),
              ),
              IconButton (
                onPressed: () async {
                var directions = await LocationService().getDirections(
                  _originController.text, 
                  _destinationController.text);
                _goToPlace(
                  directions['start_location']['lat'],
                  directions['start_location']['lng'],
                  directions['bounds_ne'],
                  directions['bounds_sw'],
                  );
                _setPolyline(directions['polyline_decoded']);
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          /*Row(
            mainAxisSize: MainAxisSize.max,
                children: [
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 15,
                    borderWidth: 1,
                    buttonSize: 50,
                    icon: Icon(
                      Icons.arrow_back_outlined,
                      color: FlutterFlowTheme.of(context).primaryColor,
                      size: 30,
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeWidget(),
                        ),
                      );
                    },
                  ),
                  Text(
                    'Solicitud',
                    style: FlutterFlowTheme.of(context).title1.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),*/
          Container(
            width: MediaQuery.of(context).size.width,
            height: 600,
            child: GoogleMap(
              mapType: MapType.normal,
              markers: _markers,
              polygons: _polygons,
              polylines: _polylines,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (point){
                setState(() {
                  polygonLatLngs.add(point);
                  _setPolygon();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToPlace(
    double lat, 
    double lng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSW
    ) async {
    //final double lat = place['geometry']['location']['lat'];
    //final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
      CameraPosition(target:LatLng(lat,lng), zoom: 12),
    ));

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(boundsSW['lat'], boundsSW['lng']),
          northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
          ),  
          25),
        );
    _setMarker(LatLng(lat, lng));
  }

}