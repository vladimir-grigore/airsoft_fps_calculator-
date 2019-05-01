import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:airsoft_fps_calculator/components/power_card.dart';
import 'package:airsoft_fps_calculator/components/speed_card.dart';

void main() {
  // Used for displaying padding and component dimensions
  debugPaintSizeEnabled=false;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Yantramanav-Thin',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Airsoft Calculator"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.orange,            
              Colors.blue[400],
              Colors.blue[600],
              Colors.blue[800],
            ],
          )
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 32.0),
            PowerCard(),
            SizedBox(height: 15.0),
            SpeedCard(),
          ], 
        ),
      ),
    );
  }
}
