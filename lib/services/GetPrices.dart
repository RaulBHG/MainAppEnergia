import 'package:intl/intl.dart';
import 'package:MainAppEnergia/objects/allObject.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import '../objects/allObject.dart';



class GetPrices{

  static var now = DateTime.now();

  static String getNowDate(String formattedDate) {
    if(formattedDate == "today")
      formattedDate = DateFormat('yyyy-MM-dd').format(now);



    return "https://api.esios.ree.es/archives/70/download_json?locale=es&date=$formattedDate";
  }

  static String getHour() {
    String formattedDate = DateFormat('HH:mm').format(now);

    return formattedDate;
  }

  static Future<AllObject> getAllData({String date = "today"}) async {
    var res = await http.get(Uri.parse(GetPrices.getNowDate(date)),
        headers: {"Accept": "application/json"});

    var resBody = json.decode(res.body);

    AllObject mainObject = new AllObject([], 0, 0, getHour(), 0, 0, "", 10000, "");
    mainObject.data = resBody["PVPC"];

    mainObject.precioTotal = 0;
    mainObject.precioMasAlto = 0;
    mainObject.precioMasBajo = 10000;
    for (var hour in mainObject.data) {
      int price = int.parse(hour["PCB"].split(",")[0]);

      //CÁLCULO PRECIO ACTUAL
      mainObject.horaActual = GetPrices.getHour();
      if (mainObject.horaActual.split(':')[0] == hour['Hora'].split('-')[0]) {
        mainObject.precioActual = price;
      }

      //CÁLCULO PRECIO MÁS ALTO
      mainObject.horaMasAlta = (price > mainObject.precioMasAlto ? hour['Hora'].split('-')[0]+":30" : mainObject.horaMasAlta);
      mainObject.precioMasAlto = (price > mainObject.precioMasAlto ? price : mainObject.precioMasAlto);

      //CÁLCULO PRECIO MÁS BAJO
      mainObject.horaMasBaja = (price < mainObject.precioMasBajo ? hour['Hora'].split('-')[0]+":30" : mainObject.horaMasBaja);
      mainObject.precioMasBajo = (price < mainObject.precioMasBajo ? price : mainObject.precioMasBajo);

      //PRECIO TOTAL
      mainObject.precioTotal += price;
    }
    mainObject.media = int.parse((mainObject.precioTotal / 24).toString().split(".")[0]);

    return mainObject;
  }


}