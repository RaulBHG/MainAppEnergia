import 'package:flutter/material.dart';
import 'package:MainAppEnergia/components/singleArea.dart';
import 'package:MainAppEnergia/objects/singleArea.dart';
import '../main.dart';

import '../utils/colors.dart' as Global;

import 'package:intl/intl.dart';

import '../components/customContainer.dart' as CustomContainer;

class HoursPage extends StatefulWidget {
  const HoursPage({Key? key}) : super(key: key);

  @override
  State<HoursPage> createState() => _HoursPageState();
}

class _HoursPageState extends State<HoursPage> {

  final PricesState pricesData= new PricesState();
  AllObject mainData = PricesState.mainObject;


  void getNewData(date) {
    pricesData.getSWData(date: date).then((value) {
      setState(() {
        mainData = PricesState.mainObject;
      });
    });
  }

  static DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
      locale: const Locale("es", "ES"),
    );
    if (picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked;
        getNewData(DateFormat('yyyy-MM-dd').format(selectedDate));
      });
    }

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
                    child: SingleArea("Precio ahora", mainData.horaActual, mainData.precioActual, Global.textMain, const EdgeInsets.only(right: 10, bottom: 15)).singleAreaWidget(),
                  ),

                  Expanded(
                    // <- para que ocupe todo lo que pueda lo que hace que al haber 2 sean 50%
                    child: SingleArea("Precio más bajo", mainData.horaMasBaja, mainData.precioMasBajo, Global.greenCorrect, const EdgeInsets.only(left: 10, bottom: 15)).singleAreaWidget(),
                  ),
                ],
              ),
              Row(
                children: [
                  // PRECIO ACTUAL
                  Expanded(
                    // <- para que ocupe todo lo que pueda lo que hace que al haber 2 sean 50%
                    child: SingleArea("Precio Medio", "", mainData.media, Global.textMain, const EdgeInsets.only(right: 10, bottom: 15)).singleAreaWidget(),
                  ),

                  Expanded(
                    // <- para que ocupe todo lo que pueda lo que hace que al haber 2 sean 50%
                    child: SingleArea("Precio más alto", mainData.horaMasAlta, mainData.precioMasAlto, Global.redWrong, const EdgeInsets.only(left: 10, bottom: 15)).singleAreaWidget(),
                  ),
                ],
              ),

              //LISTA POR HORAS
              Flexible(
                  child: CustomContainer.customContainer(
                    //TIPO LISTA
                    ListView.builder(
                      itemCount: mainData.data == null ? 0 : mainData.data.length,
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
                                          color: (int.parse(mainData.data[index]["PCB"].split(",")[0]) > mainData.media + 40)
                                              ? Global.redWrong
                                              : (int.parse(mainData.data[index]["PCB"].split(",")[0]) > (mainData.media - 40))
                                              ? Global.yellowWarning
                                              : Global.greenCorrect,
                                          borderRadius: BorderRadius.circular(10)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        "${mainData.data[index]["Hora"].split("-")[0]}:00h", style: TextStyle(fontSize: 17.5),
                                      ),
                                    )
                                  ],
                                ),

                                // Linea con colores distintos en función de la distancia de la media
                                Text(
                                  "0." +
                                      mainData.data[index]["PCB"].split(",")[0] +
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
            _selectDate(context);
          },
          backgroundColor: Global.darkBlue,
          disabledElevation: 0,
          tooltip: 'Escoger fecha',
          child: Icon(Icons.calendar_month, size: 30),
        ),
    );
  }
}
