import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_app/src/models/scan_model.dart';
import 'package:flutter_map/flutter_map.dart';

class MapaPage extends StatefulWidget {
  //mover el mapa
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final mapCOntroller = new MapController();
  List<String> mapStyle = [
    "streets-v11",
    "outdoors-v11",
    "dark-v10",
    "satellite-v9"
  ];
  int MapStyleIndex = 0;

  @override
  Widget build(BuildContext context) {
    ScanModel scanItem = ModalRoute.of(context).settings.arguments;
    //geo location

    return Scaffold(
      appBar: AppBar(
        title: Text("coordenadas"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.location_searching),
              onPressed: () {
                mapCOntroller.move(scanItem.getLatLng(), 15);
              })
        ],
      ),
      body: 
       
          _crearMapas(scanItem),
        
      
      floatingActionButton: _crearFloating(context),
    );
  }

  Widget _crearMapas(ScanModel scan) {
    var markLayout = MarkerLayerOptions(markers: <Marker>[
      Marker(
        height: 80.0,
        width: 80.0,
        point: scan.getLatLng(),
        builder: (context) => Container(
          child: Icon(
            Icons.location_on, size: 40.0,
            color: Colors.red,
            //Theme.of(context).primaryColor,
          ),
        ),
      ),
    ]);

    var mapLayout = TileLayerOptions(
        urlTemplate:
            'https://api.mapbox.com/styles/v1/mapbox/${mapStyle[MapStyleIndex]}/'
            '{id}/{z}/{x}/{y}@2x?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1IjoiZ2Vyc29ubW9yYWxlczIwMjAiLCJhIjoiY2tiZWs3dDc0MG1nZDJ4bnYwc3U0c2VwNCJ9.jDdL0oXOW1POkTo7uBpFXQ',
          'id': 'tiles'
        });

    return FlutterMap(
      mapController: mapCOntroller,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15,
      ),
      layers: [
        mapLayout,
        markLayout,
      ],
    );
  }

  Widget _crearFloating(BuildContext context) {
    return FloatingActionButton(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.map),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          MapStyleIndex = (MapStyleIndex < 3) ? MapStyleIndex + 1 : 0;
          setState(() {
            print(MapStyleIndex);
            print(mapStyle[MapStyleIndex]);
          });
        });
  }

}
