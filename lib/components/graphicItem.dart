import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../utils/colors.dart' as Global;
import '../utils/values.dart' as GlobalValues;

class GraphicsData {
  final String horizontal;
  final double vertical;

  GraphicsData(this.horizontal, this.vertical);
}

Padding graphicItem(dataGraphic) {
  return Padding(
    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
    child: //Initialize the chart widget
    Expanded(child:
    SfCartesianChart(
        plotAreaBorderColor: Colors.blue,
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          labelRotation: -40,
          majorGridLines: MajorGridLines(width: 0),
          interval: 2,
        ), //IDENTIFICA X COMO STRING
        primaryYAxis: NumericAxis(
          //Hide the gridlines of y-axis
          majorGridLines: MajorGridLines(width: 0),

        ),

        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true),

        series: <ChartSeries<GraphicsData, String>>[
          SplineAreaSeries<GraphicsData, String>(
              dataSource: dataGraphic,
              borderWidth: 2,
              borderColor: Color.fromARGB(255, 88, 186, 176),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 88, 186, 176),
                  Color.fromARGB(0, 0, 194, 249),
                ],
              ),

              xValueMapper: (GraphicsData horizontal, _) => horizontal.horizontal,
              yValueMapper: (GraphicsData vertical, _) => vertical.vertical,
              name: 'Precio luz',
              animationDuration: 3000


            // Enable data label
          )
        ])
    ),
  );
}

