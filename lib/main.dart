import 'package:flutter/material.dart';
import 'package:test_project_2/Switchs/GraphicsPage.dart';
import 'package:test_project_2/Switchs/HomePage.dart';
import 'package:test_project_2/Switchs/HoursPage.dart';
import 'package:test_project_2/services/GetPrices.dart';
import 'package:http/http.dart' as http;
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter_share/flutter_share.dart';

import 'dart:async';
import 'dart:convert';

import 'utils/colors.dart' as Global;


void main() {
  //runApp(MyApp());
  runApp(MaterialApp(
    theme: ThemeData(
      textTheme:
        TextTheme(
          bodyText2: TextStyle(color: Global.textMain),
        ),
    ),
    debugShowCheckedModeBanner: false,
    home: PricesData(),
  ));
}

class PricesData extends StatefulWidget {
  @override
  PricesState createState() => PricesState();
}

// LLAMADA API DEL IMPERIO ESPAÑOL
class PricesState extends State<PricesData> {
  static List data = [];

  static int precioTotal = 0;
  static int media = 0;

  static String horaActual = GetPrices.getHour();
  static int precioActual = 0;

  static int precioMasAlto = 0;
  static String horaMasAlta = "";

  static int precioMasBajo = 10000;
  static String horaMasBaja= "";

  Future<String> getSWData() async {
    var res = await http.get(Uri.parse(GetPrices.getNowDate()),
        headers: {"Accept": "application/json"});
    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["PVPC"];
    });
    for (var hour in data) {
      int price = int.parse(hour["PCB"].split(",")[0]);

      //CÁLCULO PRECIO ACTUAL
      if (horaActual.split(':')[0] == hour['Hora'].split('-')[0]) {
        precioActual = price;
      }

      //CÁLCULO PRECIO MÁS ALTO
      horaMasAlta = (price > precioMasAlto ? hour['Hora'].split('-')[0]+":30" : horaMasAlta);
      precioMasAlto = (price > precioMasAlto ? price : precioMasAlto);

      //CÁLCULO PRECIO MÁS BAJO
      horaMasBaja = (price < precioMasBajo ? hour['Hora'].split('-')[0]+":30" : horaMasBaja);
      precioMasBajo = (price < precioMasBajo ? price : precioMasBajo);

      //PRECIO TOTAL
      precioTotal += price;
    }
    media = int.parse((precioTotal / 24).toString().split(".")[0]);

    /*print('TOTAL: ${precioTotal}');
    print('Media: ${media}');
    print('Precio Hoy: ${precioActual}');
    print('Precio Alto: ${precioMasAlto}');
    print('Precio Bajo: ${precioMasBajo}');*/
    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: AfterSplash(),
      title: Text(
        'Welcome In SplashScreen',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image.network(
          'https://flutter.io/images/catalog-widget-placeholder.png'),
      backgroundColor: Global.textMain,
      loaderColor: Colors.red,
    );
  }

  @override
  void initState() {
    super.initState();
    getSWData();
  }
}

// OPCIONES DEL MENÚ DE ABAJO
class Option {
  final String name;
  final String icon;
  final String activeIcon;

  const Option({
    required this.name,
    required this.icon,
    required this.activeIcon,
  });
}

// DESPUÉS DE LA SPLASH SCREEN
class AfterSplash extends StatefulWidget {
  @override
  MainState createState() => MainState();
}

// ESTRUCTURA PRINCIPAL
class MainState extends State<AfterSplash> {

  //SELECCION OPCIONES
  static const List<Option> options = [
    Option(
        name: "Precios",
        icon: 'assets/images/prices_icon.png',
        activeIcon: 'assets/images/prices_icon_active.png'),
    Option(
        name: "Evolución",
        icon: 'assets/images/graph_icon.png',
        activeIcon: 'assets/images/graph_icon_active.png'),
    Option(
        name: "Compartir",
        icon: 'assets/images/share_icon.png',
        activeIcon: 'assets/images/share_icon_active.png'),
  ];

  int _selectedIndex = 0;

  static const List<Widget> _children = <Widget>[
    HoursPage(),
    GraphicsPage(),
    HomePage()
  ];
  //FIN SELECCIÓN DE OPCIONES

  //SHARE FUNCTION
  Future<void> share() async {
    print("LLEGA");
    await FlutterShare.share(
        title: 'Compartir ejemplo',
        text: 'Texto de info a compartir',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Titulo de chooser');
  }
  //FIN SHARE FUNCTION

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.mainColor,
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png', height: 70, width: 120),
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: Global.mainColor,
      ),
      body: Center(child: _children.elementAt(_selectedIndex)),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Global.greenMain,
          unselectedItemColor: Color.fromARGB(255, 189, 189, 189),
          backgroundColor: Global.mainColor,
          onTap: (value) => ((value != 2) ? (setState(() => _selectedIndex = value)) : share()),
          iconSize: 50,
          items: [
            for (final option in options)
              BottomNavigationBarItem(
                icon:
                    Image.asset(option.icon, scale: .5, height: 40, width: 25),
                activeIcon: Image.asset(option.activeIcon,
                    scale: .5, height: 40, width: 25),
                label: option.name,
                backgroundColor: Global.mainColor,
              ),
          ],
        ),
      ),
    );
  }
}
