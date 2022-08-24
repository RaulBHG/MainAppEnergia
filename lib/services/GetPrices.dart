import 'package:intl/intl.dart';




class GetPrices{

  static String getNowDate() {
    var now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    return "https://api.esios.ree.es/archives/70/download_json?locale=es&date=$formattedDate";
  }


}