import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  ListView(
        children: <Widget>[
           SizedBox(
            height: 10.0,
          ),
          _crearAvatar(),
          SizedBox(
            height: 10.0,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Esta App fue creada para fines educativos en flutter por: Gerson Morales"),
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(),
          _lanzarUrl(),
          Divider(),
          Text(" Tecnologias:"),
          FlutterLogo(),
          Text(" API: www.mapbox.com \n Packages: \n barcode_scan: ^3.0.1 \n sqflite: ^1.3.0+2 \n url_launcher:"+
           "^5.4.10 \n flutter_map: ^0.8.0"),
          




        ],
      );
   
  }

  Widget _crearAvatar() {

final customcircle = new Container(
      width: 90.0,
      //si lo deja en 100 y 100 llena el backgrodund color 
      //es decir agregamos un borde con el background color
      height: 90.0,
      decoration:  BoxDecoration(
          shape: BoxShape.circle,
          image:  DecorationImage(
          fit: BoxFit.fill,
          image:  AssetImage("assets/gerson_profile.jpg"),
                 )
));

return CircleAvatar(
  backgroundColor: Colors.grey,
child: customcircle,
radius: 50,
);




  
  
}

  Widget _lanzarUrl() {

    return  Center(
      child: new RaisedButton(
        onPressed: _launchURL,
        child: new Text('www.gersonmorales.com')));



  }

  _launchURL() async {
  
  const url = 'http://www.gersonmorales.com/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}

