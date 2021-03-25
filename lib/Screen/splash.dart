import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thirty_days_flutter/Screen/Homepage.dart';
import 'package:page_transition/page_transition.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),()=>Navigator.push(context, PageTransition(type: PageTransitionType.scale, child: homepage())));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0,300,0,0),
          child: Column(
            children: [
              Stack(
                children: [
                  Center(child: Image.asset("Assets/Images/splash.png",scale: 2,)),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,200,0,0),
                    child: const SpinKitWave(color: Colors.black, type: SpinKitWaveType.start),
                  ),
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}
