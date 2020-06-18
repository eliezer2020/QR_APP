import "package:flutter/material.dart";
import 'package:qr_app/src/BLOC/Scans_bloc.dart';
import 'package:qr_app/src/models/scan_model.dart';
import 'package:qr_app/src/providers/db_provider.dart';
import 'package:qr_app/src/utils.dart';




//no va a acceder al DB
//va a escuchar al StreamProvider

class DefaultPage extends StatefulWidget {
  @override
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
final streamProvider = new ScansBloc();

int indexType=0;
String _controlvalue = "All";

  @override
  Widget build(BuildContext context) {

    //init database view
    print("iniciando base de datos");
    streamProvider.getAllfromDB();
   

    return    Container(
      height: MediaQuery.of(context).size.height * 0.85,
      child: ListView( 
        
        children: <Widget>[
          _crearFiltro(),
          Container(
            height: MediaQuery.of(context).size.height * 0.80,
            child: StreamBuilder<List<ScanModel>>(stream:streamProvider.listenScanStream,
      //initialData: []
      builder: (context, AsyncSnapshot<List<ScanModel>> snapshot){
       if(!snapshot.hasData) {
         return Center(child: CircularProgressIndicator());
       } else {
         return ListView.builder(
         itemCount: snapshot.data.length,
         itemBuilder: (context, i ) =>
         Dismissible(
             key: UniqueKey(),
             background: Container(color: Colors.grey,),
             onDismissed: (direction){
               streamProvider.deletebyID(snapshot.data[i].id);
             } ,
                    child: buildListTile(snapshot, i, context, indexType),
         )
         );

       }

      },
      ),
          ),

      ]
      ),
    ); //listview
  }

  Widget buildListTile(AsyncSnapshot<List<ScanModel>> snapshot, int i, BuildContext context, int type) {
    

    switch (type) {
      case 0 :
      return ListTile(
         leading: Icon(Icons.account_balance_wallet),
         title: Text(snapshot.data[i].valor),
         subtitle: Text(snapshot.data[i].id.toString()),

         //el ontap es una funcion que debe ser iniciada
         onTap: ()=> lanzarURL(context, snapshot.data[i]),
       );
        break;

        case 1:
        if (snapshot.data[i].tipo=="geo") {
        return ListTile(
         leading: Icon(Icons.account_balance_wallet),
         title: Text(snapshot.data[i].valor),
         subtitle: Text(snapshot.data[i].id.toString()),

         //el ontap es una funcion que debe ser iniciada
         onTap: ()=> lanzarURL(context, snapshot.data[i]),
       );}
        
        break;

        case 2:
          if (snapshot.data[i].tipo=="http") {
        return ListTile(
         leading: Icon(Icons.account_balance_wallet),
         title: Text(snapshot.data[i].valor),
         subtitle: Text(snapshot.data[i].id.toString()),

         //el ontap es una funcion que debe ser iniciada
         onTap: ()=> lanzarURL(context, snapshot.data[i]),
       );}

        break; 

      
    }


    
  }

  Widget _crearFiltro() {

    List<DropdownMenuItem<String>> myitems = new List();
    List<String> opcionesdropdown = ["All", "Geo", "Links"];

    opcionesdropdown.forEach((item) {
      myitems.add(DropdownMenuItem(
        child: Text(item.toString()),
        value: item,
      ));
    });


    return 
    
    Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(Icons.edit),
        ),
        SizedBox(width: 10.0,),
        Text("filtrar"),
        SizedBox(width: 10.0,),
        DropdownButton(items: myitems,
        value: _controlvalue,
         onChanged: (item) {
          
          setState(() {
            _controlvalue= item;
            if (item == "All") indexType = 0;
            if (item=="Geo") indexType = 1;
            if (item=="Links") indexType = 2;


          });
        }),
      ],
    );
  }


  
}