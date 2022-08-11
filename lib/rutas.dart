import 'package:flutter/material.dart';
// import 'package:google_directions_api/google_directions_api.dart';
// import 'package:google_place/google_place.dart';
import 'package:places_test/services/directions.repository.dart';
// import 'package:places_test/places_service.dart';

// import 'directions_service.dart';
import 'models/direction.dart';

class Rutas extends StatefulWidget {
  const Rutas({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Rutas> createState() => RutasState();
}

class RutasState extends State<Rutas> {
  
  void _incrementCounter() {
    setState(() {
    });
    // getPlaces(18.457666, -69.943963);
    // getDirections();
    // var service = DirectionsRepository();
    // service.getDirections();
  }

  var service = DirectionsRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        // future: getPlaces(18.457666, -69.943963),
        future: service.getDirections(
          // * Complete response
          'Residencial Anaconda, Santo Domingo',
          'Av 27 de Febrero, Santo Domingo',
        ),
        // future: service.getDirections(
        //   // * Complete response
        //   'Residencial Anaconda, Santo Domingo',
        //   'Av 27 de Febrero, Santo Domingo',
        // ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var directions = snapshot.data as Direction;
            var routes = directions.routes;
            return ListView.builder(
              // * render Routes
              itemCount: directions.routes!.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Ruta ${index + 1}'),
                      Column(
                        // * render Legs
                        children: routes![index].legs!.map((leg) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('Duration: ${leg.duration!.text}'),
                              Text(
                                  '(${leg.departureTime!.text} - ${leg.arrivalTime!.text})'),
                              Column(
                                // * render Steps
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: leg.steps!.map((step) {
                                  if (step.travelMode == TravelMode.WALKING) {
                                    return StepWidget(
                                      instructions: step.htmlInstructions!,
                                      color: Colors.blue.withOpacity(0.5),
                                    );
                                  } else if (step.travelMode ==
                                      TravelMode.TRANSIT) {
                                    return StepTransitWidget(
                                      instructions: step.htmlInstructions!,
                                      busName: step.transitDetails!.line!.name!,
                                      color: Colors.purple,
                                    );
                                  }
                                  return Text('--${step.htmlInstructions}');
                                }).toList(),
                              )
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error.toString()}');
          } else {
            return const Text('No data');
          }
        },
      ),
    );
  }
}

class StepWidget extends StatelessWidget {
  const StepWidget({
    Key? key,
    required this.instructions,
    required this.color,
  }) : super(key: key);

  final String instructions;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 5,
          color: color,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.run_circle_outlined),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 7.0),
            child: Text(
              instructions,
              softWrap: true,
            ),
          ),
        )
      ],
    );
  }
}

class StepTransitWidget extends StatelessWidget {
  const StepTransitWidget({
    Key? key,
    required this.instructions,
    required this.color,
    required this.busName,
  }) : super(key: key);

  final String busName;
  final String instructions;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 5,
          color: color,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.bus_alert),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 7.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  busName,
                  softWrap: true,
                ),
                Text(
                  instructions,
                  softWrap: true,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
