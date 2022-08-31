import 'package:flutter/material.dart';
import 'package:test_project_2/components/singleArea.dart';
import '../main.dart';

import '../utils/colors.dart' as Global;

import '../components/customContainer.dart' as CustomContainer;

class HoursPage extends StatefulWidget {
  const HoursPage({Key? key}) : super(key: key);

  @override
  State<HoursPage> createState() => _HoursPageState();
}

class _HoursPageState extends State<HoursPage> {
  static List data = PricesState.data;
  static int media = PricesState.media;

  static String horaActual = PricesState.horaActual;
  static int precioActual = PricesState.precioActual;

  static int precioMasAlto = PricesState.precioMasAlto;
  static String horaMasAlta = PricesState.horaMasAlta;

  static int precioMasBajo = PricesState.precioMasBajo;
  static String horaMasBaja = PricesState.horaMasBaja;

  changeDate(BuildContext ctx){
    return showModalBottomSheet(
      context: ctx,
      builder: (ctx) => BottomSheet(
        onClosing: () {},
        builder: (ctx) => Container(
          height: 200,
          child: Center(
            child: Text('Hello, there!'),
          ),
        ),
      ),
    );
  }

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
                    child: SingleArea("Precio ahora", horaActual, precioActual, Global.textMain, const EdgeInsets.only(right: 10, bottom: 15)).singleAreaWidget(),
                  ),

                  Expanded(
                    // <- para que ocupe todo lo que pueda lo que hace que al haber 2 sean 50%
                    child: SingleArea("Precio más bajo", horaMasBaja, precioMasBajo, Global.greenCorrect, const EdgeInsets.only(left: 10, bottom: 15)).singleAreaWidget(),
                  ),
                ],
              ),
              Row(
                children: [
                  // PRECIO ACTUAL
                  Expanded(
                    // <- para que ocupe todo lo que pueda lo que hace que al haber 2 sean 50%
                    child: SingleArea("Precio Medio", "", media, Global.textMain, const EdgeInsets.only(right: 10, bottom: 15)).singleAreaWidget(),
                  ),

                  Expanded(
                    // <- para que ocupe todo lo que pueda lo que hace que al haber 2 sean 50%
                    child: SingleArea("Precio más alto", horaMasAlta, precioMasAlto, Global.redWrong, const EdgeInsets.only(left: 10, bottom: 15)).singleAreaWidget(),
                  ),
                ],
              ),

              //LISTA POR HORAS
              Flexible(
                  child: CustomContainer.customContainer(
                    //TIPO LISTA
                    ListView.builder(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // <- para que se extienda la info
                              children: <Widget>[
                                Row(
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 8,
                                      decoration: BoxDecoration(
                                          color: (int.parse(data[index]["PCB"].split(",")[0]) > media + 40)
                                              ? Global.redWrong
                                              : (int.parse(data[index]["PCB"].split(",")[0]) > (media - 40))
                                              ? Global.yellowWarning
                                              : Global.greenCorrect,
                                          borderRadius: BorderRadius.circular(10)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        "${data[index]["Hora"].split("-")[0]}:00h", style: TextStyle(fontSize: 17.5),
                                      ),
                                    )
                                  ],
                                ),

                                // Linea con colores distintos en función de la distancia de la media
                                Text(
                                  "0." +
                                      data[index]["PCB"].split(",")[0] +
                                      "€/kWh",
                                  style: TextStyle(
                                      fontSize: 17.5),
                                )
                              ]),
                        ),
                      );
                  },
                )
              )),

            ],
          ),
        ),

        //BOTÓN ELEGIR FECHA
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            changeDate(context);
          },
          backgroundColor: Global.darkBlue,
          disabledElevation: 0,
          tooltip: 'Escoger fecha',
          child: Icon(Icons.calendar_month, size: 30),
        ),
    );
  }
}
