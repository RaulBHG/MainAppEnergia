import 'package:flutter/material.dart';
import 'package:MainAppEnergia/Switchs/GraphicsPage.dart';
import 'package:MainAppEnergia/Switchs/HomePage.dart';
import 'package:MainAppEnergia/Switchs/HoursPage.dart';
import 'package:MainAppEnergia/objects/allObject.dart';
import 'package:MainAppEnergia/services/GetPrices.dart';

import 'package:splashscreen/splashscreen.dart';
import 'package:flutter_share/flutter_share.dart';

import 'package:flutter_localizations/flutter_localizations.dart';


import 'utils/colors.dart' as Global;


void main() {
  //runApp(MyApp());
  runApp(MaterialApp(

    //PARA PODER PONER EL CALENDARIO EN ESPAÑOL
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate
    ],

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

  static List dataIn = [];
  static int precioTotalIn = 0;
  static int mediaIn = 0;
  static String horaActualIn = GetPrices.getHour();
  static int precioActualIn = 0;
  static int precioMasAltoIn = 0;
  static String horaMasAltaIn = "";
  static int precioMasBajoIn = 10000;
  static String horaMasBajaIn = "";

  static AllObject mainObject = new AllObject(dataIn, precioTotalIn, mediaIn, horaActualIn, precioActualIn, precioMasAltoIn, horaMasAltaIn, precioMasBajoIn, horaMasBajaIn);
  //Future<AllObject> mainObject;

  //AllObject dataDay = new AllObject();

  Future<String> getSWData({String date = "today"}) async {

    mainObject = await GetPrices.getAllData(date: date);

    return "SUCCESS";
  }

  void getSW() {
    getSWData();
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

// DESPUÉS DE LA SPLASH SCREEN
class AfterSplash extends StatefulWidget {
  @override
  MainState createState() => MainState();
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
        height: 70,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Global.greenMain,
          unselectedItemColor: Color.fromARGB(255, 189, 189, 189),
          backgroundColor: Global.mainColor,
          onTap: (value) => ((value != 2) ? (setState(() => _selectedIndex = value)) : share()),
          items: [
            for (final option in options)
              BottomNavigationBarItem(
                icon: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                    child: Image.asset(option.icon, height: 20, width: 25),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Image.asset(option.activeIcon, height: 20, width: 25),
                ),
                label: option.name,
                backgroundColor: Global.mainColor,
              ),
          ],
        ),
      ),
    );
  }
}
