import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/scan_model.dart';

lanzarURL(BuildContext context, ScanModel scaneo) async {
  if (scaneo.tipo=="http") {
  if (await canLaunch(scaneo.valor)) {
    await launch(scaneo.valor);
  } else {
    throw 'Could not launch link';
  }
  }else {
    Navigator.pushNamed(context, "mapas", arguments: scaneo); 
  }



}