import 'package:flutter/material.dart';

import 'package:airsoft_fps_calculator/components/speed_calculator.dart';

class SpeedCard extends StatefulWidget {
  @override
  _SpeedCard createState() => _SpeedCard();
}

class _SpeedCard extends State<SpeedCard> {
  double _bodyHeight = 150.0;
  bool isExpanded = false;

  double titleFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width / 18;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          child: AnimatedContainer(
            curve: Curves.fastOutSlowIn,
            duration: Duration(milliseconds: 250),
            height: _bodyHeight,
            child: AnimatedCrossFade(
              duration: Duration(milliseconds: 500),
              crossFadeState: !isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              firstChild: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(Icons.toll, size: 60.0,),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Speed Calculator', 
                          style: TextStyle(fontSize: titleFontSize(context), fontWeight: FontWeight.bold)
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Calculate nozzle velocity based on bb weight and power (Joules)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: IconButton(
                        iconSize: 40.0,
                        icon: Icon(Icons.keyboard_arrow_down),
                          onPressed: () {
                            setState(() {
                              this.isExpanded = !isExpanded;
                              this._bodyHeight = isExpanded ? 450 : 150.0;
                            });
                          },
                        ),
                      ),
                  ),
                ],
              ),
              secondChild: Container(
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: IconButton(
                          iconSize: 40.0,
                          icon: Icon(Icons.keyboard_arrow_up),
                            onPressed: () {
                              setState(() {
                                this.isExpanded = !isExpanded;
                                this._bodyHeight = isExpanded ? 450 : 150.0;
                              });
                            },
                          ),
                        ),
                    ),
                    SpeedCalculator(),
                  ],
                ),
              ),
            ),
          ),              
        ),
      ),
    );
  }
}