import 'package:flutter/material.dart';
import 'package:qr_app/src/pages/home_page.dart';
import 'package:qr_app/src/pages/mapas_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QRAPP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage() ,
        "mapas": (context)=> MapaPage(),
      
      }
    );
  }
}


 