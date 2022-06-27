import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:safari/cars/mainappbar.dart';
class BookCar extends StatefulWidget {
  const BookCar({Key? key}) : super(key: key);

  @override
  _BookCarState createState() => _BookCarState();
}

class _BookCarState extends State<BookCar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
            title: Text(
                'Book Now',
              style: Theme.of(context).textTheme.headline6,
            ),
        ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20,left: 8,right: 8,bottom: 10),
        child: Column(
          children: [
            Center(
              child: Row(
                children: [
                  Text(
                    'enter your location',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(width: 20,),
                  IconButton(
                      onPressed: (){
                        map();
                      },
                      icon: Icon(
                          Icons.location_pin,
                        size: 25,
                        color: Colors.black,
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget map() {
    return new FlutterMap(
      options: new MapOptions(
        center: new LatLng(51.5, -0.09),
        zoom: 13.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken': '<PUT_ACCESS_TOKEN_HERE>',
            'id': 'mapbox.streets',
          },
        ),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 80.0,
              height: 80.0,
              point: new LatLng(51.5, -0.09),
              builder: (ctx) =>
              new Container(
                child: new FlutterLogo(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

