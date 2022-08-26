import 'package:flutter/material.dart';
import 'package:test_project_2/components/graphicItem.dart';
import 'package:test_project_2/components/singleArea.dart';
import 'package:test_project_2/main.dart';
import '../utils/colors.dart' as Global;

import '../components/customContainer.dart' as CustomContainer;
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class GraphicsPage extends StatefulWidget {
  const GraphicsPage({Key? key}) : super(key: key);

  @override
  State<GraphicsPage> createState() => _GraphicsPageState();
}

class _GraphicsPageState extends State<GraphicsPage> {

  static List data = PricesState.data;
  static int media = PricesState.media;

  static String horaActual = PricesState.horaActual;
  static int precioActual = PricesState.precioActual;

  static int precioMasAlto = PricesState.precioMasAlto;
  static String horaMasAlta = PricesState.horaMasAlta;

  static int precioMasBajo = PricesState.precioMasBajo;
  static String horaMasBaja = PricesState.horaMasBaja;

  List<GraphicsData> dataGraphic = [];

  Future<List> getGraphicsData() async {
    for (var element in data) {
      print("Hora ${element['Hora'].split('-')[0]}");
      print("Hora ${element["PCB"].split(",")[0]}");
      dataGraphic.add(GraphicsData("${element['Hora'].split('-')[0]}:00", double.parse(element["PCB"].split(",")[0])));
    }
    return dataGraphic;
  }

  @override
  void initState() {
    super.initState();
    getGraphicsData();
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
              
              Flexible(child: CustomContainer.customContainer(
                  Column(children: [
                    graphicItem(dataGraphic)

                  ])
                )
              )
            ],
          ),
        )
    );
  }

}
/*
Column(children: [
//Initialize the chart widget
                SfCartesianChart(
                primaryXAxis: CategoryAxis(),
            // Chart title
                title: ChartTitle(text: 'Half yearly sales analysis'),
            // Enable legend
                legend: Legend(isVisible: true),
            // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_SalesData, String>>[
                SplineAreaSeries<_SalesData, String>(
                dataSource: dataGraphic,
                gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                Color.fromARGB(255, 88, 186, 176),
                Color.fromARGB(0, 0, 194, 249),
                ],
                ),
                xValueMapper: (_SalesData sales, _) => sales.year,
                yValueMapper: (_SalesData sales, _) => sales.sales,
                name: 'Sales',
            // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true))
                ]),
                ])*/
