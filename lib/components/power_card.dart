import 'package:flutter/material.dart';

import 'package:airsoft_fps_calculator/components/joules_calculator.dart';

class PowerCard extends StatefulWidget {
  final String system;
  final bool isExpanded;
  final Function onExpand;

  PowerCard({Key key, this.system, this.isExpanded, this.onExpand}) : super(key: key);
  
  @override
  _PowerCard createState() => _PowerCard();
}

class _PowerCard extends State<PowerCard> {
  double _bodyHeight = 150.0;
  bool isExpanded;

  @override
  void didUpdateWidget(PowerCard oldWidget) {
    isExpanded = widget.isExpanded;
    this._bodyHeight = isExpanded ? 450 : 150.0;
    super.didUpdateWidget(oldWidget);
  }

  void initState() {
    isExpanded = widget.isExpanded;
    super.initState();
  }

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
                    child: Icon(Icons.scatter_plot, size: 60.0,),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Power Calculator', 
                          style: TextStyle(fontSize: titleFontSize(context), fontWeight: FontWeight.bold)
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Calculate Joules based on bb weight and nozzle velocity',
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
                              widget.onExpand("powerCard");
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
                                widget.onExpand("powerCard");
                              });
                            },
                          ),
                        ),
                    ),
                    JoulesCalculator(system: widget.system),
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
