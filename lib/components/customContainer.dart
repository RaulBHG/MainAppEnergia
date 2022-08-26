
import 'package:flutter/material.dart';
import '../utils/colors.dart' as Global;
import '../utils/values.dart' as GlobalValues;

Container customContainer(child) {
  return Container(
    decoration: BoxDecoration(
        color: Global.lightGray,
        borderRadius: BorderRadius.circular(GlobalValues.raiusSection) // <- anular border radius de la forma rectángulo
    ),
    child: child,
  );
}

