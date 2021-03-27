import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thirty_days_flutter/Screen/Homepage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thirty_days_flutter/Screen/Login.dart';


class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override

  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),()=>
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => sign())));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Center(child: Image.asset("Assets/Images/splash.png",scale: 2,)),

              Padding(
                padding: const EdgeInsets.fromLTRB(0,180,0,0),
                child: const SpinKitWave(color: Colors.black, type: SpinKitWaveType.start),
              ),
            ],
          )


        ],
      ),
    );
  }
}
