import 'package:flutter/material.dart';
import 'package:test_project_2/Switchs/GraphicsPage.dart';
import 'package:test_project_2/Switchs/HomePage.dart';
import 'package:test_project_2/Switchs/HoursPage.dart';
import 'utils/colors.dart' as Global;
import 'package:intl/intl.dart';
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

class PricesState extends State<PricesData> {

  String getNowDate() {
    var now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    return "https://api.esios.ree.es/archives/70/download_json?locale=es&date=$formattedDate";
  }

  //String url = getNowDate();
  static List data = [];
  static int precioTotal = 0;
  static int media = 0;

  Future<String> getSWData() async {
    var res = await http
        .get(Uri.parse(getNowDate()), headers: {"Accept": "application/json"});
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

class Option {
  final String name;
  final IconData icon;
  final Color color;
  const Option({
    required this.name,
    required this.icon,
    required this.color,
  });
}

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

class MainState extends State<AfterSplash> {

  static const List<Option> options = [
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
  }

}