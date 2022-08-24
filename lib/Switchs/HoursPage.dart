import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/colors.dart' as Global;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.mainColor,
      body:
        ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            shadowColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          data[index]["Hora"].split("-")[0] +
                              "h - " +
                              data[index]["Hora"].split("-")[1] +
                              "h",
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.black87),
                        ),
                        Container(
                          width: 60,
                          height: 15,
                          decoration: new BoxDecoration(
                              color: (int.parse(data[index]["PCB"]
                                  .split(",")[0]) <
                                  media)
                                  ? Color.fromARGB(255, 33, 245, 36)
                                  : (int.parse(data[index]["PCB"]
                                  .split(",")[0]) <
                                  (media+40))
                                  ? Color.fromARGB(
                                  255, 245, 202, 25)
                                  : Color.fromARGB(
                                  255, 255, 0, 0),
                              borderRadius:
                              BorderRadius.circular(10)),
                        ),
                        Text(
                          "0." +
                              data[index]["PCB"].split(",")[0] +
                              "€/kWh",
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.black87),
                        )
                      ]),
                ],
              ),
            ),
          );
        },
      ),




    );
  }
}
