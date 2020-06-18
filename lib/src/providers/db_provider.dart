import 'dart:io';

import 'package:qr_app/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path_provider/path_provider.dart';
import "package:path/path.dart";
//exponer paquete externo a la importacion
export 'package:qr_app/src/models/scan_model.dart';

class DBprovider {
//patron singleton unica DB en toda la app
//instancia de la base de datos
  static Database _database;
  //construcror privado

  DBprovider._();
  //constructor para una sola instancia
  static final DBprovider db = DBprovider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    //aqui cojo la coña direccion
    Directory directoryDB = await getApplicationDocumentsDirectory();

    //aqui tengo la coña direccion
    final pathDB = join(directoryDB.path, "my_database.db");

    return await openDatabase(pathDB, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {


          
      await db.execute(
        "CREATE TABLE ScanTable (id INTEGER PRIMARY KEY, tipo TEXT, valor TEXT)");
    });
  }

  //crear registros




  //opcional insertar mediante mapa final res= await db.insert("Scantable", nuevoScan.toJson());
  nuevoRegistro(ScanModel nuevoScan) async {

    final db= await database;

final res = await db.rawInsert(
"INSERT Into ScanTable (id, tipo, valor) "
"VALUES (${nuevoScan.id}, '${nuevoScan.tipo}', '${nuevoScan.valor}')"

);
return res;


  }

  //recuperar registro
  Future<ScanModel> getScanID (int id) async {
final db =await database;
//regresa una puta tabla , se convierte a un JSON y recupero el primer elemento 
final res = await db.query("ScanTable", where: "id=?",whereArgs: [id] );
return res.isNotEmpty ? ScanModel.fromJson(res.first) : null; 
}

//recuperar todos los regitros
Future<List<ScanModel>> getAll () async{
final db =await database;
final res = await db.query("ScanTable");

List<ScanModel> resList = res.isNotEmpty ?
			res.map((scanItem) => ScanModel.fromJson(scanItem)).toList()
			: List<ScanModel>();

return resList;
}


//recuperar registro po tipo
Future<List<ScanModel>> getByType (String tipo) async{
final db =await database;
final res = await db.rawQuery("SELEC * FROM ScanTable WHERE tipo='$tipo' ");

List<ScanModel> resList = res.isNotEmpty ?
			res.map((scanItem) => ScanModel.fromJson(scanItem)).toList
			: [];

return resList;
}

//actualizar registros

updateDatabse (ScanModel newRegister) async {
final db = await database;
//actualizar no toda la tabla sino el registro nuevo
final resp = await db.update("ScanTable", newRegister.toJson(),where: "id=?" ,whereArgs: [newRegister.id]); 
return resp;


}

Future<int>deletebyID(int id) async {
final db = await database;
final resp = db.delete("ScanTable", where: "id=?", whereArgs: [id]); 
return resp; // cantidad de registros borrados

}

Future<int>deleteAll() async {
final db = await database;
final resp = db.rawDelete("DELETE FROM ScanTable");
return resp; // cantidad de registros borrados

}

}
