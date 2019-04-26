import 'package:flutter/material.dart';
import 'dart:math';

class JoulesCalculator extends StatefulWidget {
  JoulesCalculator({Key key}) : super(key: key);

  @override
  _JoulesCalculator createState() => _JoulesCalculator();
}

class _JoulesCalculator extends State<JoulesCalculator> {

  TextEditingController _speedController;
  TextEditingController _weightController;
  String joules = "";

  @override
  void initState() {
    _speedController = TextEditingController();
    _weightController = TextEditingController();
    super.initState();
  }

  void calculateJoules() {
    double _joules = 0.5 * (double.parse(_weightController.text) / 1000) * pow(int.parse(_speedController.text), 2);
    setState(() {
      joules = _joules.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "Calculate power based on bb weight and speed",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontFamily: "Yantramanav-Thin", fontWeight: FontWeight.w100),
          ),
        ),
        // Speed (fps, m/s) text input row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _speedController.text = (int.parse(_speedController.text) - 1).toString();
                });
              },
              backgroundColor: Colors.indigo,
              child: Icon(Icons.remove),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: 130.0,
                height: 100.0,
                alignment: Alignment.center,
                child: Theme(
                  data: ThemeData(
                    primaryColor: Colors.black,
                    primaryColorDark: Colors.black,
                  ),
                  child: TextField(
                    controller: _speedController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "MPS",
                    ),
                    onChanged: (input) {
                      setState(() {
                        
                      });
                    },
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _speedController.text = (int.parse(_speedController.text) + 1).toString();
                });
              },
              backgroundColor: Colors.indigo,
              child: Icon(Icons.add),
            ),
          ],
        ),
        // BB weight Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _weightController.text = (double.parse(_weightController.text) - 0.01).toStringAsFixed(2);
                });
              },
              backgroundColor: Colors.indigo,
              child: Icon(Icons.remove),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: 130.0,
                height: 100.0,
                alignment: Alignment.center,
                child: Theme(
                  data: ThemeData(
                    primaryColor: Colors.black,
                    primaryColorDark: Colors.black,
                  ),
                  child: TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "BB weight",
                    ),
                    onChanged: (input) {
                      setState(() {
                        
                      });
                    },
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _weightController.text = (double.parse(_weightController.text) + 0.01).toStringAsFixed(2);
                });
              },
              backgroundColor: Colors.indigo,
              child: Icon(Icons.add),
            ),
          ],
        ),
        RaisedButton(
          onPressed: () {
            calculateJoules();
          },
          color: Colors.indigo,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text("Calculate", style: TextStyle(fontSize: 20)),
        ),
        Text("Energy: $joules Joules"),
      ],
    );
  }
}