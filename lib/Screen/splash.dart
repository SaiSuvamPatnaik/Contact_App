import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thirty_days_flutter/Screen/Homepage.dart';
import 'package:thirty_days_flutter/Screen/add_contacts.dart';
import 'package:thirty_days_flutter/Screen/contacts.dart';
import 'package:thirty_days_flutter/Screen/history.dart';
import 'package:fluttertoast/fluttertoast.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Timer(Duration(seconds: 3),()=>Navigator.push(
        //context,
        //MaterialPageRoute(builder: (context) => homepage())));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0,240,0,0),
          child: Column(


            children: [
              Stack(
                children: [
                  Center(child: Image.asset("Assets/Images/splash.png",scale: 2,)),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,165,0,0),
                      child: Text("TO MY",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,210,0,0),
                      child: Text("CONTACT APP",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,280,0,0),
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
