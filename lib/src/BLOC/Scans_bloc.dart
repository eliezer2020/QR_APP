
import 'dart:async';
//auto importa scan model 
import 'package:qr_app/src/models/scan_model.dart';
import 'package:qr_app/src/providers/db_provider.dart';



class ScansBloc {

//factory para no retornar instancias nuevas de la clase
//si no para retornar existentes u otras cosas
factory ScansBloc(){
  return _singleton;
}
  
//recuperar base de datos 
ScansBloc._internal(){
getAllfromDB();
}


//instancia 
static final _singleton = new ScansBloc._internal();


//crear streamcontroler en broadcast 

final scanStreamController = StreamController<List<ScanModel>>.broadcast();

//escuchar stream
Stream<List<ScanModel>> get listenScanStream => scanStreamController.stream;



//cerrar streamcontroloer
void dispose (){
  scanStreamController?.close();
}


//*************manejador de eventos *************


//obtener todos
void getAllfromDB () async {
scanStreamController.sink.add(await DBprovider.db.getAll());

}

void addToDB(ScanModel nuevoScan)async{
  await DBprovider.db.nuevoRegistro(nuevoScan);
  //refrescar
  getAllfromDB();
}

//borrar por ide
void deletebyID(int id) async {
await DBprovider.db.deletebyID(id);
//refrescar DB
getAllfromDB();

}

void deleteDB () async {
  DBprovider.db.deleteAll();
  getAllfromDB();
}






 

}