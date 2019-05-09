import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io' show Platform;
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/services.dart';
import 'package:airsoft_fps_calculator/components/power_card.dart';
import 'package:airsoft_fps_calculator/components/speed_card.dart';

void main() {
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
  String system = "imperial";
  bool powerCardExpanded = false;
  bool speedCardExpanded = false;
  BannerAd _bannerAd;
  ScrollController _scrollController = ScrollController();

  String getAdUnitId() {
    if(Platform.isAndroid) {
     return "ca-app-pub-6798433568226907/7035588275";
    } else if(Platform.isIOS) {
     return "ca-app-pub-6798433568226907/8521018195";
    } else {
      return BannerAd.testAdUnitId;
    }
  }

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['airsoft'],
    nonPersonalizedAds: true,
  );

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: getAdUnitId(),
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
    );
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

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
    await Future.delayed(Duration(milliseconds: 350));
    
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
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Row(
              children: <Widget>[
                Text("MPS"),
                IconButton(
                  iconSize: 36,
                  icon: Icon(Icons.swap_horiz),
                  onPressed: (){
                    swapMeasurementSystem();
                  },
                ),
                Text("FPS"),
              ],
            ),
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
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            SizedBox(height: 10.0),
            PowerCard(system: system, isExpanded: powerCardExpanded, onExpand: updateExpandedState),
            SpeedCard(system: system, isExpanded: speedCardExpanded, onExpand: updateExpandedState),
            SizedBox(height: 50.0),
          ], 
        ),
      ),
    );
  }
}
