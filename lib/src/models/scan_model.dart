import 'package:latlong/latlong.dart';

class ScanModel {
  int id;
  String tipo;
  String valor;

  ScanModel({
    this.id,
    this.tipo,
    this.valor,
  }){
if (this.valor.contains("http")){
this.tipo="http";
}else {
  this.tipo="geo";
}

  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };

      LatLng getLatLng() {

        
        //ignora los 4 primeros chr y divide donde hay coma
        //regresa una lista de string
        final arreglo = valor.substring(4).split(",");

        double lat= double.parse(arreglo[0]);
        double long = double.parse(arreglo[1]);

        return new LatLng(lat,long);

      }
}
