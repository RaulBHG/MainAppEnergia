import 'package:flutter/material.dart';
import 'package:test_project_2/components/graphicItem.dart';
import 'package:test_project_2/components/singleArea.dart';
import 'package:test_project_2/objects/singleArea.dart';
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

  final AllObject mainData = PricesState.mainObject;

  /*static List data = mainData.data;
  static int media = mainData.media;

  static String horaActual = mainData.horaActual;
  static int precioActual = mainData.precioActual;

  static int precioMasAlto = mainData.precioMasAlto;
  static String horaMasAlta = mainData.horaMasAlta;

  static int precioMasBajo = mainData.precioMasBajo;
  static String horaMasBaja = mainData.horaMasBaja;*/

  List<GraphicsData> dataGraphic = [];

  Future<List> getGraphicsData() async {
    for (var element in mainData.data) {
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
