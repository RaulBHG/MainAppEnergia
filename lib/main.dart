import 'package:flutter/material.dart';
import 'package:test_project_2/Switchs/GraphicsPage.dart';
import 'package:test_project_2/Switchs/HomePage.dart';
import 'package:test_project_2/Switchs/HoursPage.dart';
import 'package:test_project_2/services/GetPrices.dart';
import 'utils/colors.dart' as Global;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:splashscreen/splashscreen.dart';


void main() {
  //runApp(MyApp());
  runApp(MaterialApp(
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

  Future<String> getSWData() async {
    var res = await http
        .get(Uri.parse(GetPrices.getNowDate()), headers: {"Accept": "application/json"});
    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["PVPC"];
    });
    for (var hour in data) {
      print("precio:${hour["PCB"].split(",")[0]}");
      precioTotal += int.parse(hour["PCB"].split(",")[0]);
    }
    media = int.parse((precioTotal/24).toString().split(".")[0]);
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
      backgroundColor: Colors.white,
      loaderColor: Colors.red,
    );
    /*return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Tu precio de luz"),
        backgroundColor: Colors.amberAccent,
      ),
      /*
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shadowColor: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    data[index]["Hora"].split("-")[0] +
                                        "h - " +
                                        data[index]["Hora"].split("-")[1] +
                                        "h",
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.black87),
                                  ),
                                  Container(
                                    width: 60,
                                    height: 15,
                                    decoration: new BoxDecoration(
                                        color: (int.parse(data[index]["PCB"]
                                                    .split(",")[0]) <
                                                250)
                                            ? Color.fromARGB(255, 33, 245, 36)
                                            : (int.parse(data[index]["PCB"]
                                                        .split(",")[0]) <
                                                    300)
                                                ? Color.fromARGB(
                                                    255, 245, 202, 25)
                                                : Color.fromARGB(
                                                    255, 255, 0, 0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  Text(
                                    "0." +
                                        data[index]["PCB"].split(",")[0] +
                                        "€/kWh",
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.black87),
                                  )
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      */
      body: Center(
        child: _children.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.black, // <-- This works for fixed
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white,
        onTap: (value) => setState(() => _selectedIndex = value),
        items: [
          for (final option in options) BottomNavigationBarItem(
            icon: Icon(option.icon),
            label: option.name,
            backgroundColor: option.color

          ),
        ],
      ),
    );*/
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
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

  /*static const List<Option> options = [
    Option(name: "Ahora", icon: Icons.today, color: Colors.black),
    Option(name: "Por horas", icon: Icons.access_time, color: Colors.blueGrey),
    Option(name: "Gráfico", icon: Icons.add_chart, color: Colors.grey),
  ];

  int _selectedIndex = 0;
  Option get option => options [_selectedIndex];
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _children = <Widget>[
    HomePage(),
    HoursPage(),
    GraphicsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Tu precio de luz"),
        backgroundColor: Colors.amberAccent,
      ),
      /*
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shadowColor: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    data[index]["Hora"].split("-")[0] +
                                        "h - " +
                                        data[index]["Hora"].split("-")[1] +
                                        "h",
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.black87),
                                  ),
                                  Container(
                                    width: 60,
                                    height: 15,
                                    decoration: new BoxDecoration(
                                        color: (int.parse(data[index]["PCB"]
                                                    .split(",")[0]) <
                                                250)
                                            ? Color.fromARGB(255, 33, 245, 36)
                                            : (int.parse(data[index]["PCB"]
                                                        .split(",")[0]) <
                                                    300)
                                                ? Color.fromARGB(
                                                    255, 245, 202, 25)
                                                : Color.fromARGB(
                                                    255, 255, 0, 0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  Text(
                                    "0." +
                                        data[index]["PCB"].split(",")[0] +
                                        "€/kWh",
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.black87),
                                  )
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      */
      body: Center(
        child: _children.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.black, // <-- This works for fixed
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white,
        onTap: (value) => setState(() => _selectedIndex = value),
        items: [
          for (final option in options) BottomNavigationBarItem(
              icon: Icon(option.icon),
              label: option.name,
              backgroundColor: option.color

          ),
        ],
      ),
    );
  }*/
}

// ESTRUCTURA PRINCIPAL
class MainState extends State<AfterSplash> {

  static const List<Option> options = [
    Option(name: "Precios", icon: 'assets/images/prices_icon.png', activeIcon: 'assets/images/graph_icon.png'),
    Option(name: "Evolución", icon: 'assets/images/graph_icon.png', activeIcon: 'assets/images/prices_icon.png'),
    Option(name: "Compartir", icon: 'assets/images/prices_icon.png', activeIcon: 'assets/images/graph_icon.png'),

  ];

  int _selectedIndex = 0;
  //Option get option => options [_selectedIndex];
  //static const TextStyle optionStyle =
  //TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _children = <Widget>[
    HoursPage(),
    GraphicsPage(),
    HomePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.mainColor,

      appBar: AppBar(
        title: Image.asset('assets/images/logo.png', height: 100, width: 150),
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: Global.mainColor,
      ),

      body: Center(
        child:
          _children.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: SizedBox(height: 80, child:
        BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          showUnselectedLabels: true,
          selectedItemColor: Colors.greenAccent,
          unselectedItemColor: Colors.white,
          onTap: (value) => setState(() => _selectedIndex = value),
          iconSize: 50,
          items: [
            for (final option in options) BottomNavigationBarItem(
                icon: Image.asset(option.icon, scale: .5,  height: 40, width: 25),
                activeIcon: Image.asset(option.activeIcon, scale: .5,  height: 40, width: 25),
                label: option.name,
                backgroundColor: Global.mainColor,


            ),
          ],
        ),
      ),
    );
  }

}