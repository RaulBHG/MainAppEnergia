
import 'package:flutter/material.dart';
import '../utils/colors.dart' as Global;
import '../utils/values.dart' as GlobalValues;

class SingleArea {
  String title;
  String hour;
  int price;
  Color color;
  var padding = const EdgeInsets.only(right: 7.5, bottom: 15);

  //PADDING FORMAT: const EdgeInsets.only(right: 7.5, bottom: 15)
  SingleArea(this.title, this.hour, this.price, this.color, this.padding);
  // CUSTOM CARD SECTION
  Card singleAreaWidget() {
    return Card(
      color: Global.lightGray,
      shadowColor: Colors.transparent,
      margin:
      this.padding,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(GlobalValues.raiusSection) // <- anular border radius de la forma rectángulo
      ),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(this.title, style: TextStyle(fontSize: 17.5, color: this.color)),
              ],
            ),
            Row(
              children: [
                Text(this.hour, style: TextStyle(fontSize: 17.5, color: this.color)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text("0.${this.price}€", style: TextStyle(fontSize: 28.0, color: this.color)),
                Text(" kWh", style: TextStyle(fontSize: 15.0, color: this.color)),
              ],
            )

          ],
        ),
      ),
    );
  }
}


