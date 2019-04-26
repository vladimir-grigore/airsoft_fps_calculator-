import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:airsoft_fps_calculator/components/joules_calculator.dart';

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
      home: MyHomePage(title: 'Airsoft Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Airsoft Calculator"),
      ),
      body: Center(
        child: Container(
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
          child: JoulesCalculator(),
        ),
      ),
    );
  }
}
