import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locatey/models/place.dart';
import 'package:locatey/screens/search.dart';
import 'package:locatey/services/geolocator_service.dart';
import 'package:locatey/services/places_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MyApp(),
        '/locate': (context) => MyApp2(),
      },
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lime[50],
        appBar: AppBar(
          title: Text('Charge your wheels!'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(
          children: [
            Container(
              // child: new Image.network('https://i.ibb.co/t3hz3jF/logo.png'),
              child: new Image.network(
                  'https://i.ibb.co/hD4XtzT/Electric-car-icon-Vector-Illustration-Electric-car-and-charging-station-Illustration-eps10-vector-ic.jpg'),
              // child: new Image.asset('assets/images/logo.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                child: Text(
                    'Go Electric & Go Green! \nSupervisedby:\nAmritesh kumar\ndeveloped by:\nRahil Hussain:1813119\nSarthak Prasad:1813044',
                    style: TextStyle(
                      fontFamily: 'Satisfy',
                      fontSize: 21.5,
                    )),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //DropdownExample(),
                    ElevatedButton(
                      child: Text('Locatev station'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/locate');
                      },
                    ),
                  ],
                )),
            Container(),
          ],
        ));
  }
}

class MyApp2 extends StatelessWidget {
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider<Position, Future<List<Place>>>(
          update: (context, position, places) {
            return (position != null)
                ? placesService.getPlaces(position.latitude, position.longitude)
                : null;
          },
        )
      ],
      child: MaterialApp(
        title: 'Locatey',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Locatey'),
            backgroundColor: Colors.green,
          ),
          body: Search(),
        ),
      ),
    );
  }
}
