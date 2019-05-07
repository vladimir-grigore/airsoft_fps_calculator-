import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_admob/firebase_admob.dart';

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
  String system = "metric";
  bool powerCardExpanded = false;
  bool speedCardExpanded = false;
  BannerAd _bannerAd;
  ScrollController _scrollController = ScrollController();

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    // testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['airsoft'],
    nonPersonalizedAds: true,
  );

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      }
    );
  }

  @override
  void initState() {
    super.initState();

    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _bannerAd = createBannerAd()..load()..show();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  void updateExpandedState(widgetName) {
    if(widgetName == "powerCard") {
      setState(() {
        powerCardExpanded = !powerCardExpanded;
        if(speedCardExpanded == true) {
          speedCardExpanded = false;
        }
      });
    }

    if(widgetName == "speedCard") {
      setState(() {
        speedCardExpanded = !speedCardExpanded;
        if(powerCardExpanded == true) {
          powerCardExpanded = false;
        }
      });
      scrollToBottom();
    }
  }

  void scrollToBottom() async {
    await Future.delayed(Duration(milliseconds: 250));
    
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }

  void swapMeasurementSystem() {
    if(system == "metric") {
      setState(() {
        this.system = "imperial";
      });
    } else {
      setState(() {
        this.system = "metric";
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Airsoft Calculator"),
        actions: <Widget>[
          IconButton(
            iconSize: 36,
            icon: Icon(Icons.swap_horiz),
            onPressed: (){
              swapMeasurementSystem();
            },
          ),
        ],
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
        child: Padding(
          padding: EdgeInsets.only(bottom: 50.0),
          child: ListView(
            controller: _scrollController,
            children: <Widget>[
              SizedBox(height: 10.0),
              PowerCard(system: system, isExpanded: powerCardExpanded, onExpand: updateExpandedState),
              SpeedCard(system: system, isExpanded: speedCardExpanded, onExpand: updateExpandedState),
            ], 
          ),
        ),
      ),
    );
  }
}
