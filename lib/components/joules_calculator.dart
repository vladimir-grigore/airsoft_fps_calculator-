import 'package:flutter/material.dart';
import 'dart:math';

class JoulesCalculator extends StatefulWidget {
  final String system;
  JoulesCalculator({Key key, this.system}) : super(key: key);

  @override
  _JoulesCalculator createState() => _JoulesCalculator();
}

class _JoulesCalculator extends State<JoulesCalculator> {
  TextEditingController _speedController;
  TextEditingController _weightController;
  bool _loopActive = false;
  bool _buttonPressed = false;
  String joules = "0";

  @override
  void initState() {
    _speedController = TextEditingController();
    _weightController = TextEditingController();

    super.initState();
  }

  @override
  void didUpdateWidget(JoulesCalculator oldWidget) {
    if(widget.system != oldWidget.system) {
      if(widget.system == "imperial" && _speedController.text != ""){
        _speedController.text = (int.parse(_speedController.text) * 3.2808).toStringAsFixed(0);
      }

      if(widget.system == "metric" && _speedController.text != ""){
        _speedController.text = (int.parse(_speedController.text) * 0.3048).toStringAsFixed(0);
      }

    }

    super.didUpdateWidget(oldWidget);
  }

  double convertSpeed() {
    if(widget.system == "imperial") {
      return double.parse(_speedController.text) * 0.3048;
    } else {
      return double.parse(_speedController.text);
    }
  }

  void calculateJoules() {
    if(_weightController.text == "" || _speedController.text == "") {
      joules = 0.toStringAsFixed(2);
    } else {
      double _joules = 0.5 * (double.parse(_weightController.text) / 1000) * pow(convertSpeed(), 2);
      setState(() {
        joules = _joules.toStringAsFixed(2);
      });
    }
  }

  void _increaseSpeedWhilePressed() async {
    if(_loopActive) return;
    _loopActive = true;

    while(_buttonPressed) {
      setState(() {
        if(_speedController.text == "") {
          _speedController.text = "0";
        }
        _speedController.text = (int.parse(_speedController.text) + 1).toString();
      });

      await Future.delayed(Duration(milliseconds: 100));
    }

    _loopActive = false;
  }

  void _decreaseSpeedWhilePressed() async {
    if(_loopActive) return;
    _loopActive = true;

    while(_buttonPressed) {
      if(_speedController.text == "") {
        _speedController.text = "0";
      }

      setState(() {
        _speedController.text = (int.parse(_speedController.text) - 1).toString();
      });

      await Future.delayed(Duration(milliseconds: 100));
    }

    _loopActive = false;
  }

  void _increaseBBWeightWhilePressed() async {
    if(_loopActive) return;
    _loopActive = true;

    while(_buttonPressed) {
      if(_weightController.text == "") {
        _weightController.text = "0";
      }

      setState(() {
        _weightController.text = (double.parse(_weightController.text) + 0.01).toStringAsFixed(2);
      });

      await Future.delayed(Duration(milliseconds: 100));
    }

    _loopActive = false;
  }

  void _decreaseBBWeightWhilePressed() async {
    if(_loopActive) return;
    _loopActive = true;

    while(_buttonPressed) {
      if(_weightController.text == "") {
        _weightController.text = "0";
      }

      setState(() {
        _weightController.text = (double.parse(_weightController.text) - 0.01).toStringAsFixed(2);
      });

      await Future.delayed(Duration(milliseconds: 100));
    }

    _loopActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Calculate power based on bb weight and speed",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontFamily: "Yantramanav-Thin", fontWeight: FontWeight.w400),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.indigo,
              child: Listener(
                onPointerDown: (details) {
                  _buttonPressed = true;
                  _decreaseSpeedWhilePressed();
                },
                onPointerUp: (details) {
                  _buttonPressed = false;
                },
                child: Icon(Icons.remove),
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: 130.0,
                height: 80.0,
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
                      labelText: widget.system == "metric" ? "MPS" : "FPS",
                    ),
                    onChanged: (input) {},
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.indigo,
              child: Listener(
                onPointerDown: (details) {
                  _buttonPressed = true;
                  _increaseSpeedWhilePressed();
                },
                onPointerUp: (details) {
                  _buttonPressed = false;
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.indigo,
              child: Listener(
                onPointerDown: (details) {
                  _buttonPressed = true;
                  _decreaseBBWeightWhilePressed();
                },
                onPointerUp: (details) {
                  _buttonPressed = false;
                },
                child: Icon(Icons.remove),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: 130.0,
                height: 80.0,
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
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.indigo,
              child: Listener(
                onPointerDown: (details) {
                  _buttonPressed = true;
                  _increaseBBWeightWhilePressed();
                },
                onPointerUp: (details) {
                  _buttonPressed = false;
                },
                child: Icon(Icons.add),
              ),
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
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Text("Energy: $joules Joules", style: TextStyle(fontSize: 20.0)),
        ),
      ],
    );
  }
}