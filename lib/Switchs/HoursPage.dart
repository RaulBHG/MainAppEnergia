import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/colors.dart' as Global;
import '../utils/values.dart' as GlobalValues;
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HoursPage extends StatefulWidget {
  const HoursPage({Key? key}) : super(key: key);

  @override
  State<HoursPage> createState() => _HoursPageState();
}

class _HoursPageState extends State<HoursPage> {
  List data = PricesState.data;
  int precioTotal = PricesState.precioTotal;
  int media = PricesState.media;
  String horaActual = PricesState.horaActual;
  int precioActual = PricesState.precioActual;
  int precioMasAlto = PricesState.precioMasAlto;
  int precioMasBajo = PricesState.precioMasBajo;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Global.mainColor,
        body: Container(
          margin: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  // PRECIO ACTUAL
                  Expanded(
                    // <- para que ocupe todo lo que pueda lo que hace que al haber 2 sean 50%
                    child: Card(
                      color: Global.lightGray,
                      shadowColor: Colors.transparent,
                      margin:
                          EdgeInsets.only(right: 7.5, bottom: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(GlobalValues.raiusSection) // <- anular border radius de la forma rectángulo
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Precio ahora", style: TextStyle(fontSize: 17.5)),
                              ],
                            ),
                            Row(
                              children: [
                                Text(horaActual, style: TextStyle(fontSize: 17.5)),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text("0.${precioActual}€", style: TextStyle(fontSize: 28.0)),
                                Text(" kWh", style: TextStyle(fontSize: 15.0)),
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    // <- para que ocupe todo lo que pueda lo que hace que al haber 2 sean 50%
                    child: Card(
                      color: Global.lightGray,
                      shadowColor: Colors.transparent,
                      margin:
                      EdgeInsets.only(left: 7.5, bottom: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(GlobalValues.raiusSection) // <- anular border radius de la forma rectángulo
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Precio más bajo", style: TextStyle(fontSize: 17.5, color: Global.greenCorrect)),
                              ],
                            ),
                            Row(
                              children: [
                                Text(horaActual, style: TextStyle(fontSize: 17.5, color: Global.greenCorrect)),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text("0.${precioActual}€", style: TextStyle(fontSize: 28.0)),
                                Text(" kWh", style: TextStyle(fontSize: 15.0)),
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // PRECIO ACTUAL
                  Expanded(
                    // <- para que ocupe todo lo que pueda lo que hace que al haber 2 sean 50%
                    child: Card(
                      color: Global.lightGray,
                      shadowColor: Colors.transparent,
                      margin:
                      EdgeInsets.only(right: 7.5, bottom: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(GlobalValues.raiusSection) // <- anular border radius de la forma rectángulo
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Precio medio", style: TextStyle(fontSize: 17.5)),
                              ],
                            ),
                            Row(
                              children: [
                                Text("", style: TextStyle(fontSize: 17.5)),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text("0.${media}€", style: TextStyle(fontSize: 28.0)),
                                Text(" kWh", style: TextStyle(fontSize: 15.0)),
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    // <- para que ocupe todo lo que pueda lo que hace que al haber 2 sean 50%
                    child: Card(
                      color: Global.lightGray,
                      shadowColor: Colors.transparent,
                      margin:
                      EdgeInsets.only(left: 7.5, bottom: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(GlobalValues.raiusSection) // <- anular border radius de la forma rectángulo
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Precio ahora", style: TextStyle(fontSize: 17.5)),
                              ],
                            ),
                            Row(
                              children: [
                                Text("horaActual", style: TextStyle(fontSize: 17.5)),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text("0.€", style: TextStyle(fontSize: 28.0)),
                                Text(" kWh", style: TextStyle(fontSize: 15.0)),
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //LISTA POR HORAS
              Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Global.lightGray,
                        borderRadius: BorderRadius.circular(GlobalValues.raiusSection) // <- anular border radius de la forma rectángulo
                    ),
                    //TIPO LISTA
                    child: ListView.builder(
                      itemCount: data == null ? 0 : data.length,
                      // <- señala la cantidad de elementos que va a tener la lista
                      itemBuilder: (BuildContext context, int index) {
                      //CADA ELEMENTO
                      return Card(
                        color: Colors.transparent,
                        shadowColor: Colors.transparent,
                        margin: const EdgeInsets.all(0),
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius
                                .zero // <- anular border radius de la forma rectángulo
                            ),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          // <- padding en todos los lados
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom: BorderSide(color: Global.lighterGray),
                          )),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // <- para que se extienda la info
                              children: <Widget>[
                                Text(
                                  data[index]["Hora"].split("-")[0] +
                                      "h - " +
                                      data[index]["Hora"].split("-")[1] +
                                      "h",
                                  style: TextStyle(
                                      fontSize: 20.0),
                                ),
                                // Linea con colores distintos en función de la distancia de la media
                                Container(
                                  width: 60,
                                  height: 15,
                                  decoration: BoxDecoration(
                                      color: (int.parse(data[index]["PCB"]
                                                  .split(",")[0]) <
                                              media)
                                          ? Color.fromARGB(255, 33, 245, 36)
                                          : (int.parse(data[index]["PCB"]
                                                      .split(",")[0]) <
                                                  (media + 40))
                                              ? Color.fromARGB(255, 245, 202, 25)
                                              : Color.fromARGB(255, 255, 0, 0),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                Text(
                                  "0." +
                                      data[index]["PCB"].split(",")[0] +
                                      "€/kWh",
                                  style: TextStyle(
                                      fontSize: 20.0),
                                )
                              ]),
                        ),
                      );
                  },
                ),
              ))
            ],
          ),
        ));
  }
}
