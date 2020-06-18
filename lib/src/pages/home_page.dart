import 'package:flutter/material.dart';
import 'package:qr_app/src/BLOC/Scans_bloc.dart';
import 'package:qr_app/src/models/scan_model.dart';
//import 'package:qr_app/src/models/scan_model.dart';
import 'package:qr_app/src/pages/about_page.dart';
import 'package:barcode_scan/barcode_scan.dart';

import 'package:qr_app/src/pages/default_page.dart';

//solo se accede en el bloc
//import 'package:qr_app/src/providers/db_provider.dart';
  



  
   

class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //stream provider

  final streamProvider = new ScansBloc();
  
int _pageIndex = 0; 

  @override
  Widget build(BuildContext contet){
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("QR app"),
        //si lo quiere en izq tendria que ser con leading 
        actions: <Widget>[
          
          IconButton(icon: Icon(Icons.delete_forever), onPressed: (){
            streamProvider.deleteDB();
            print("DB has been purged");
          }),
        ],
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){
        print("scanning QR............");
        //geo:40.68154819995313,-73.89745130976566
        //https://www.udemy.com/
        _scanQR();
              },
              child: Icon(Icons.filter_center_focus),),
        
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              body: callPage(_pageIndex),
                bottomNavigationBar: _bottonNavigation(),
                  
                
              
            );
          }
        
          Widget _bottonNavigation() => BottomNavigationBar(
            
            //numero de botones en el bottomnav
            currentIndex: _pageIndex,
            onTap: (index){
              
              setState(() {
                _pageIndex = index;
              });
            },
            items:
          
          [
            BottomNavigationBarItem(icon: Icon(Icons.map),
            title: Text("Home")), 
             BottomNavigationBarItem(icon: Icon(Icons.info),
             title: Text("About")), 
        
          ]
          );
        
          Widget callPage(int pageIndex) {
             switch( pageIndex){
               case 0: return DefaultPage();
        
               case 1: return AboutPage();
        
               default: return DefaultPage();
               
        
             }
          }
        
          Future<String> _scanQR() async {
            
            var respuestaScanner;


            /*   simular
           final _nuevoScan = ScanModel(valor: "https://www.udemy.com/");
            final _nuevoScan2 = ScanModel(valor: "geo:40.68154819995313,-73.89745130976566");
            
              //DBprovider.db.nuevoRegistro(_nuevoScan);
              streamProvider.addToDB(_nuevoScan);
              streamProvider.addToDB(_nuevoScan2);
            */




            
            try {
                //respuestaScanner = await  BarcodeScanner.scan(); 
                 respuestaScanner= await  BarcodeScanner.scan();
                
                 print(" el escanner leyo  ${respuestaScanner.rawContent}");
                  print("********************** finish scan exit 0 **************************");
                  streamProvider.addToDB(new ScanModel(valor: respuestaScanner.rawContent));
                 return respuestaScanner.format;

            } catch (e){
                respuestaScanner = e.toString();
                print("no se pudo escanear............");
                return "no se pudo escanear";
            } 


          }
}