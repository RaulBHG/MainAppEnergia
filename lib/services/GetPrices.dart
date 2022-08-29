import 'package:intl/intl.dart';




class GetPrices{

  static var now = DateTime.now();

  static String getNowDate() {
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    return "https://api.esios.ree.es/archives/70/download_json?locale=es&date=$formattedDate";
  }

  static String getHour() {
    String formattedDate = DateFormat('HH:mm').format(now);

    return formattedDate;
  }


}