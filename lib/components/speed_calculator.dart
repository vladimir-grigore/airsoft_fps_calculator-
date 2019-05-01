import 'package:flutter/material.dart';
import 'dart:math';

class SpeedCalculator extends StatefulWidget {
  SpeedCalculator({Key key}) : super(key: key);

  @override
  _SpeedCalculator createState() => _SpeedCalculator();
}

class _SpeedCalculator extends State<SpeedCalculator> {
  TextEditingController _joulesController;
  TextEditingController _weightController;
  bool _loopActive = false;
  bool _buttonPressed = false;
  String speed = "0";

  @override
  void initState() {
    _joulesController = TextEditingController();
    _weightController = TextEditingController();
    super.initState();
  }

  void calculateSpeed() {
    double _speed = sqrt((2 * double.parse(_joulesController.text)) / (double.parse(_weightController.text) / 1000));

    setState(() {
      speed = _speed.toStringAsFixed(2);
    });
  }

  void _increaseJoulesWhilePressed() async {
    if(_loopActive) return;
    _loopActive = true;

    while(_buttonPressed) {
      if(_joulesController.text == "") {
        _joulesController.text = "0";
      }

      setState(() {
        _joulesController.text = (double.parse(_joulesController.text) + 0.01).toStringAsFixed(2);
      });

      await Future.delayed(Duration(milliseconds: 100));
    }

    _loopActive = false;
  }

  void _decreaseJoulesWhilePressed() async {
    if(_loopActive) return;
    _loopActive = true;

    while(_buttonPressed) {
      if(_joulesController.text == "") {
        _joulesController.text = "0";
      }

      setState(() {
        _joulesController.text = (double.parse(_joulesController.text) - 0.01).toStringAsFixed(2);
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
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Text(
            "Calculate speed based on bb weight and power",
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
                  _decreaseJoulesWhilePressed();
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
                    controller: _joulesController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Joules",
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
                  _increaseJoulesWhilePressed();
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
            calculateSpeed();
          },
          color: Colors.indigo,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text("Calculate", style: TextStyle(fontSize: 20)),
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("Speed: $speed m/s", style: TextStyle(fontSize: 20.0)),
        ),
      ],
    );
  }
}
